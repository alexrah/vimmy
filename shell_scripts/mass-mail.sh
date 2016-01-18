 #!/bin/bash
 result=""
 while [ -z "$result" ]; do
  echo "Write the recipient email:"
  read email
  result=`echo $email | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"`
 done
    
 echo "Write the number of emails to send"
 read count
        for i in `seq 1 $count`;
        do
                echo $i ":" $result
        done  
