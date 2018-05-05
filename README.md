# ssh-scanner
ssh password guessing，ssh登录密码破解

### 简介  
   将nmap扫描器和hydra扫描器组合使用，先用nmap探测主机是否开放22端口；如开放，然后用hydra暴力破解ssh服务的密码。这里给出了top 100,1000,10000的常用密码本。  

### 使用条件  
   Ubuntu 18.04 64bit  
   sudo apt install nmap hydra

### 运行程序  
   ./hydra.sh -p ./password.txt -f ./iplist.txt #对文件中的IP进行破解  
   ./hydra.sh -p ./password.txt -l 192.168.9.0/24 #对网段中的IP进行破解  
运行图：  
![Image test](https://github.com/scu-igroup/ssh-scanner/blob/master/image/22-pass.gif)   
  
密码本见：  
https://github.com/danielmiessler/SecLists/tree/master/Passwords  

注意：  
    在测试过程中，会出现开了端口确连接不了的错误，程序会打印出来，这是正常现象，可以忽略。
