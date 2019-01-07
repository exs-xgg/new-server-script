#!/bin/bash  
#THIS SCRIPT IS FOR THE CENTOS 6 SERVER CONFIGURATION 

	echo " 
CHOOSE A NUMBER FOR BASIC CONFIGURATION OF THE NEW SERVER 
'press ctrl + c to exit' 

1. Change hostname 
2. Insert proxy on yum 
3. Yum update 
4. Install wget 
5. Insert proxy  
6. Insert banner 
7. Install grep,man,tar,zip,unzip,net-tools 
8. Static ip address 
9. DHCP ip address 
10. FQDN 
11. Reboot 

	" 

read -p "-" input 

if [ $input -eq 1 ] 
	then 

	read -p "insert your hostname: " hostname 
	echo HOSTNAME=$hostname > /etc/sysconfig/network 
	echo "done!" 
	./newserverscript.sh  

elif [ $input -eq 2 ]	 
	then 

	echo proxy=http://proxy.ph.gfl:3128 >> /etc/yum.conf 
	echo "done!" 
        ./newserverscript.sh 

elif [ $input -eq 3 ] 
	then 
 
	yum update -y 
	echo "done!" 
	./newserverscript.sh 

elif [ $input -eq 4 ] 
	then 
	 
	echo "installing wget" 
	yum install -y wget* 
	echo "done!" 
	./newserverscript.sh 

elif [ $input -eq 5 ] 
	then 

	echo https_proxy = http://proxy.ph.gfl:3128 >> /etc/wgetrc 
	echo http_proxy = http://proxy.ph.gfl:3128 >> /etc/wgetrc 
	export http_proxy=http://proxy.ph.gfl:3128
	export https_proxy=http://proxy.ph.gfl:3128
	export all_proxy=http://proxy.ph.gfl:3128

	echo "done!" 
	./newserverscript.sh 

elif [ $input -eq 6 ] 
	then 

	read -p "please inster banner: 
 " banner 
	echo $banner > /etc/issue.net 
	echo Banner /etc/issue.net >> /etc/ssh/sshd_config 
	service sshd restart 
	echo "done!" 
	./newserverscript.sh 

elif [ $input -eq 7 ] 
	then 

	yum install -y grep* man* tar* zip* unzip* net-tools* 
	echo "done!" 
	echo https_proxy = http://proxy.ph.gfl:3128 >> /etc/wgetrc 
	echo http_proxy = http://proxy.ph.gfl:3128 >> /etc/wgetrc 
	./newserverscript.sh 

elif [ $input -eq 8 ] 
	then 
	 
	sed -i -e 's/dhcp/static/g' /etc/sysconfig/network-scripts/ifcfg-eth0 
	read -p "Insert your ip address and subnetmask: " ip mask 
	echo IPADDR=$ip >> /etc/sysconfig/network-scripts/ifcfg-eth0 
	echo NETMASK=$mask >> /etc/sysconfig/network-scripts/ifcfg-eth0 
	service network restart 
	ip addr 
	./newserverscript.sh 
	 

elif [ $input -eq 9 ] 
	then 

	sed -i -e 's/static/dhcp/' /etc/sysconfig/network-scripts/ifcfg-eth0 
	sed -i -e 's/IPADDR/#IPADDR/' /etc/sysconfig/network-scripts/ifcfg-eth0 
	sed -i -e 's/NETMASK/#NETMASK/' /etc/sysconfig/network-scripts/ifcfg-eth0 
	service network restart 
	ip addr 
	echo "done!" 
	 

elif [ $input -eq 10 ] 
        then 
	 
	read -p "IP, FQDN, hostname, : " ip fqdn hostname 
        echo "$ip $fqdn $hostname" >> /etc/hosts 
	./newserverscript.sh 

elif [ $input -eq 11 ] 
	then 

	reboot 
	echo "done!" 

else 

	echo "this is simple." 
	 

fi 

