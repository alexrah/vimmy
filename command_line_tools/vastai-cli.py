#!/usr/bin/python3
import os
import json
from typing import List, Optional, Literal, Union, cast
from dataclasses import dataclass
import argparse


def print_table(dict_data, col_list=None):
    """ Pretty print a list of dictionaries (myDict) as a dynamically sized table.
   If column names (colList) aren't specified, they will show in random order.
   Author: Thierry Husson - Use it as you want but don't blame me.
   """
    if not col_list: col_list = list(dict_data[0].keys() if dict_data else [])
    print_list = [col_list]  # 1st row = header
    for item in dict_data: print_list.append([str(item[col] if item[col] is not None else '') for col in col_list])
    colSize = [max(map(len, col)) for col in zip(*print_list)]
    format_str = ' | '.join(["{{:<{}}}".format(i) for i in colSize])
    print_list.insert(1, ['-' * i for i in colSize])  # Seperating line
    for item in print_list: print(format_str.format(*item))


data_reference = """
ID        CUDA   N  Model     PCIE  cpu_ghz  vCPUs   RAM  Disk  $/hr    DLP    DLP/$   score  NV Driver   Net_up  Net_down  R     Max_Days  mach_id  status    ports  country
11684738  12.2  1x  RTX_4090  12.3  2.3      24.0   64.4  1608  0.2467  106.6  432.30  174.9  535.183.01  77.7    105.9     97.0  154.6     22990    verified  249    Guangxi,_CN
"""

json_string = """[
 {
  "ask_contract_id": 11684738,
  "bundle_id": 1598539855,
  "bundled_results": null,
  "bw_nvlink": 0.0,
  "compute_cap": 890,
  "cpu_arch": "amd64",
  "cpu_cores": 96,
  "cpu_cores_effective": 24.0,
  "cpu_ghz": 2.3,
  "cpu_name": "AMD EPYC 7642 48-Core Processor",
  "cpu_ram": 64393,
  "credit_discount_max": 0.4,
  "cuda_max_good": 12.2,
  "direct_port_count": 249,
  "discount_rate": 0.0,
  "discounted_dph_total": 0.2466759259259259,
  "discounted_hourly": 0.0,
  "disk_bw": 2545.2940000000003,
  "disk_name": "INTEL SSDPE2KX080T8",
  "disk_space": 1607.875,
  "dlperf": 106.63705612622635,
  "dlperf_per_dphtotal": 432.29616236749547,
  "dph_base": 0.24666666666666665,
  "dph_total": 0.2466759259259259,
  "dph_total_adj": 0.2466759259259259,
  "driver_vers": 535183001,
  "driver_version": "535.183.01",
  "duration": 13356528.565657616,
  "end_date": 1735707781.0,
  "external": null,
  "flops_per_dphtotal": 336.34646627378856,
  "geolocation": "Guangxi, CN",
  "geolocode": 921675020,
  "gpu_arch": "nvidia",
  "gpu_display_active": false,
  "gpu_frac": 0.25,
  "gpu_ids": [
   82267
  ],
  "gpu_lanes": 16,
  "gpu_mem_bw": 3108.4,
  "gpu_name": "RTX 4090",
  "gpu_ram": 24564,
  "gpu_total_ram": 24564,
  "has_avx": 1,
  "host_id": 125418,
  "hosting_type": 0,
  "hostname": null,
  "id": 11684738,
  "inet_down": 105.9,
  "inet_down_cost": 0.0,
  "inet_up": 77.7,
  "inet_up_cost": 0.0,
  "instance": {
   "discountTotalHour": 0,
   "discountedTotalPerHour": 9.25925925925926e-06,
   "diskHour": 9.25925925925926e-06,
   "gpuCostPerHour": 0,
   "totalHour": 9.25925925925926e-06
  },
  "internet_down_cost_per_tb": 0.0,
  "internet_up_cost_per_tb": 0.0,
  "is_bid": false,
  "logo": "/static/logos/vastai_small2.png",
  "machine_id": 22990,
  "min_bid": 0.2,
  "mobo_name": "H12SSL",
  "num_gpus": 1,
  "os_version": "20.04",
  "pci_gen": 4.0,
  "pcie_bw": 12.3,
  "public_ipaddr": "8.218.223.191",
  "reliability": 0.9700835,
  "reliability2": 0.9700835,
  "reliability_mult": 0.7710531,
  "rentable": true,
  "rented": false,
  "rn": 1,
  "score": 190.03429818220016,
  "search": {
   "discountTotalHour": 0,
   "discountedTotalPerHour": 0.2466759259259259,
   "diskHour": 9.25925925925926e-06,
   "gpuCostPerHour": 0.24666666666666665,
   "totalHour": 0.2466759259259259
  },
  "start_date": 1722348655.847011,
  "static_ip": false,
  "storage_cost": 0.0013333333333333335,
  "storage_total_cost": 9.25925925925926e-06,
  "time_remaining": "",
  "time_remaining_isbid": "",
  "total_flops": 82.968576,
  "vericode": 1,
  "verification": "verified",
  "vram_costperhour": 0.010282798675568581,
  "webpage": null
 }
]
"""

results_dict = json.loads(json_string)


# print_table(results_dict)

@dataclass
class FieldsToKeep:
    name: str
    label: str
    transform: Literal[
        None, 'count', 'mb_to_gb', 'gb_to_tb', 'float_to_int', 'float_to_float', 'minutes_to_days', 'hours_to_week', 'hours_to_month', 'hours_to_day']


@dataclass
class FieldsRawInstance:
    discountTotalHour: float
    discountedTotalPerHour: float
    diskHour: float
    gpuCostPerHour: float
    totalHour: float


@dataclass
class FieldsRaw:
    ask_contract_id: int
    bundle_id: int
    bundled_results: None
    bw_nvlink: float
    compute_cap: int
    cpu_arch: str
    cpu_cores: int
    cpu_cores_effective: float
    cpu_ghz: float
    cpu_name: str
    cpu_ram: int
    credit_discount_max: float
    cuda_max_good: float
    direct_port_count: int
    discount_rate: float
    discounted_dph_total: float
    discounted_hourly: float
    disk_bw: float
    disk_name: str
    disk_space: float
    dlperf: float
    dlperf_per_dphtotal: float
    dph_base: float
    dph_total: float
    dph_total_adj: float
    driver_vers: int
    driver_version: str
    duration: float
    end_date: float
    external: Union[None, str]
    flops_per_dphtotal: float
    geolocation: str
    geolocode: int
    gpu_arch: str
    gpu_display_active: bool
    gpu_frac: float
    gpu_ids: List[int]
    gpu_lanes: int
    gpu_max_power: float
    gpu_max_temp: float
    gpu_mem_bw: float
    gpu_name: str
    gpu_ram: int
    gpu_total_ram: int
    has_avx: Literal[0, 1]
    host_id: int
    hosting_type: int
    hostname: Union[None, str]
    id: int
    inet_down: float
    inet_down_cost: float
    inet_up: float
    inet_up_cost: float
    instance: FieldsRawInstance
    internet_down_cost_per_tb: float
    internet_up_cost_per_tb: float
    is_bid: bool
    logo: str
    machine_id: int
    min_bid: float
    mobo_name: str
    num_gpus: int
    os_version: str
    pci_gen: float
    pcie_bw: float
    public_ipaddr: str
    reliability: float
    reliability2: float
    reliability_mult: float
    rentable: bool
    rented: bool
    rn: int
    score: float
    search: FieldsRawInstance
    start_date: float
    static_ip: bool
    storage_cost: float
    storage_total_cost: float
    time_remaining: str
    time_remaining_isbid: str
    total_flops: float
    vericode: int
    verification: Literal[None, 'verified']
    vram_costperhour: float
    webpage: Union[None, str]
    vms_enabled: bool


@dataclass
class ParsedArgs:
    search_level: Optional[Literal['high', 'mid', 'low']]
    search_create: bool
    return_first_machine_id: bool


# class FieldsProcessed(TypedDict):
#     id: int
#     cuda_max_good: float
#     gpu_ids: int
#     gpu_name:
#


class FieldsMapper:

    def __init__(self, fields: List[FieldsRaw]) -> None:
        self.__fields_list_raw = fields
        self.__fields_list_processed: List = []
        self.__process_fields()

    __fields_to_keep: List[FieldsToKeep] = [
        FieldsToKeep(name="id", label="ID", transform=None),
        FieldsToKeep(name='cuda_max_good', label='CUDA', transform=None),
        FieldsToKeep(name='gpu_ids', label='N', transform='count'),
        FieldsToKeep(name='gpu_name', label='GPU', transform=None),
        FieldsToKeep(name='gpu_total_ram', label='VRAM', transform='mb_to_gb'),
        FieldsToKeep(name='total_flops', label='TFLOPS', transform='float_to_int'),
        FieldsToKeep(name='cpu_cores_effective', label='vCPUs', transform=None),
        FieldsToKeep(name='cpu_ram', label='RAM', transform='mb_to_gb'),
        FieldsToKeep(name='disk_space', label='Disk(GB)', transform='float_to_int'),
        FieldsToKeep(name='dph_total', label='$/hr', transform='float_to_float'),
        FieldsToKeep(name='dph_total', label='$/w', transform='hours_to_week'),
        FieldsToKeep(name='dph_total', label='$/m', transform='hours_to_month'),
        FieldsToKeep(name='dlperf', label='DLP', transform='float_to_float'),
        FieldsToKeep(name='inet_up', label='UP Mbps', transform=None),
        FieldsToKeep(name='inet_up_cost', label='UP T/$', transform='gb_to_tb'),
        FieldsToKeep(name='inet_down', label='DOWN Mbps', transform=None),
        FieldsToKeep(name='inet_down_cost', label='DOWN T/$', transform='gb_to_tb'),
        FieldsToKeep(name='storage_total_cost', label='$/30GB/day', transform='hours_to_day'),
        FieldsToKeep(name='duration', label='MaxDays', transform='minutes_to_days'),
        FieldsToKeep(name='geolocation', label='Location', transform=None),
    ]

    def count(self, value: List) -> int:
        return len(value)

    def mb_to_gb(self, value: float) -> str:
        return "{:.2f}".format(round(value / 1024, 2))

    def gb_to_tb(self, value: float) -> str:
        return "{:.2f}".format(value * 1024)

    def float_to_int(self, value: float) -> int:
        return int(value)

    def float_to_float(self, value: float) -> float:
        return float("{:.3f}".format(value))

    def hours_to_day(self, value: float) -> float:
        return float("{:.3f}".format(value * 24))

    def minutes_to_days(self, value: float) -> int:
        return int(value / 60 / 60 / 24)

    def hours_to_week(self, value: float) -> float:
        return float("{:.3f}".format(value * 24 * 7))

    def hours_to_month(self, value: float) -> float:
        return float("{:.3f}".format(value * 24 * 30))

    def __process_fields(self):
        for fields_raw in self.__fields_list_raw:
            processed_data = {}
            for field_to_keep in self.__fields_to_keep:
                processed_data[field_to_keep.label] = self.__getattribute__(field_to_keep.transform)(
                    fields_raw.__getattribute__(field_to_keep.name)) \
                    if field_to_keep.transform else fields_raw.__getattribute__(field_to_keep.name)
            self.__fields_list_processed.append(processed_data)

    def get_fields(self):
        return self.__fields_list_processed


class CliCommands:
    parsed_args: ParsedArgs
    first_machine_id_returned: int

    def __init__(self):
        self.__parse_args()
        if hasattr(self.parsed_args, 'search_level'):
            self.__search()

    def __search(self):
        vastai_cli_search_base_command = 'vastai search offers'

        vastai_cli_search_query = ''

        if self.parsed_args.search_level == 'high':
            vastai_cli_search_query = (
                '"disk_space>=30 verified=True rentable=True dph<=0.60 total_flops>=130 gpu_ram>=24 '
                'cpu_cores_effective>=16 cpu_ram>=64 dlperf>=150 inet_down_cost<=0.001 '
                'inet_up_cost<=0.001 reliability>=0.95 external=False storage_cost<=0.25"')
        elif self.parsed_args.search_level == 'mid':
            vastai_cli_search_query = (
                '"disk_space>=30 verified=True rentable=True dph<=0.30 total_flops>=50 gpu_ram>=24 '
                'cpu_cores_effective>=16 cpu_ram>=64 dlperf>=100 inet_down_cost<=0.001 '
                'inet_up_cost<=0.001 reliability>=0.95 external=False storage_cost<=0.25"')
        elif self.parsed_args.search_level == 'low':
            vastai_cli_search_query = (
                '"disk_space>=30 verified=True rentable=True dph<=0.15 total_flops>=20 gpu_ram>=15 '
                'cpu_cores_effective>=8 cpu_ram>=32 dlperf>=20 inet_down_cost<=0.001 '
                'inet_up_cost<=0.001 reliability>=0.95 external=False storage_cost<=0.25"')

        vastai_cli_search_query_output = '--raw'
        vastai_cli_search_query_order = '-o dlperf-'
        vastai_cli_search_query_storage = '--storage=30'

        search_stream = os.popen(f"{vastai_cli_search_base_command}"
                                 f" {vastai_cli_search_query}"
                                 f" {vastai_cli_search_query_order}"
                                 f" {vastai_cli_search_query_storage}"
                                 f" {vastai_cli_search_query_output}")

        search_data = search_stream.read()
        search_results = ''
        try:
            search_results = [FieldsRaw(**item) for item in json.loads(search_data)]
        except ValueError:
            print('Decoding JSON has failed')
            print(search_data)

        if len(search_results) > 0:
            fields = FieldsMapper(search_results)
            fields_data = fields.get_fields()
            self.first_machine_id_returned = fields_data[0].get('ID')

            if self.parsed_args.return_first_machine_id:
                print(self.first_machine_id_returned)
            else:
                print_table(fields_data)

            if self.parsed_args.search_create:
                self.__create()

        else:
            print('No search results')

    def __create(self):
        print(f"creating instance from machine id: {self.first_machine_id_returned}")

    def __parse_args(self):
        parser = argparse.ArgumentParser()
        # parser.add_argument('search', help='Search command', choices=['high', 'mid', 'low'])
        #
        search_subparser = parser.add_subparsers()
        search_parser = search_subparser.add_parser('search', help='Search command')
        search_parser.add_argument('search_level', help='GPU types', choices=['high', 'mid', 'low'])
        search_parser.add_argument('--create', help='Create instance using first item returned', action='store_true',
                                   dest='search_create')
        search_parser.add_argument('--first-id', help='Return only the first machine ID', action='store_true',
                                   dest='return_first_machine_id')

        self.parsed_args = cast(ParsedArgs, parser.parse_args())


if __name__ == '__main__':
    CliCommands()
