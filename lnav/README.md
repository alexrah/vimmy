@see [LNAV](https://github.com/tstack/lnav/)
@see [LNAV custom log formats](https://docs.lnav.org/en/latest/formats.html)

### Install Custom shortcuts
* CTRL + h => Hide unmarked lines
* CTRL + g => Show unmarked lines

```bash
ln -s ~/.dotfiles/vimmy/lnav/config.json ~/.config/lnav/config.json
```

### Install WP debug.log format
```bash
ln -s ~/.dotfiles/vimmy/lnav/wpdebuglog.json ~/.config/lnav/formats/installed/wpdebuglog.json
```

### Install PHP-FPM log format
```bash
lnav -i https://github.com/damiankloip/lnav-php.git
```

### Install Monolog log format
- monolog.json
custom format for monolog generated .log files 
@see implementation here: [Logger.php](https://bitbucket.org/vareseweb/v2media_paywall/raw/e608dd0325aee94d119a6c3440d2c4e8c9a0e641/backend/classes/src/V2mPaywall/Logger.php)

```bash
ln -s ~/.dotfiles/vimmy/lnav/monolog.json ~/.config/lnav/formats/installed/monolog.json
```

#### Monolog requirements
```
		/**
		 * Based on  @see LineFormatter::SIMPLE_FORMAT
		 * Regexp to format log file:
		 * ^(?<timestamp>\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]) (?<level>\w+) >> (?<component>[a-zA-Z0-9\\]+) >> (?<message>.+) >> (?<body>.*)
		 **/
		$sFormat = "[%datetime%] %level_name% >> %channel% >> %message% >> %context% %extra%\n";

		$oFormatter = new LineFormatter($sFormat, LineFormatter::SIMPLE_DATE, true);

    $oStreamHandler = new StreamHandler(ABSPATH .'wp-content/monolog.log', $this->logLevel);
 		$oStreamHandler->setFormatter($oFormatter);

		$this->oLogger = new ML($sChannel);
		$this->oLogger->pushHandler($oStreamHandler);
```
