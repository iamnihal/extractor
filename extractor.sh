#!/bin/bash     
clear
echo -e "\t\t\t\t -------------------"
echo -e "\t\t\t\t !     Extractor    !"
echo -e "\t\t\t\t -------------------"
echo -e "\t\t\t\t\t\t By Nihal"
echo "-----------------------------"
echo "            MENU             |"
echo "-----------------------------|"
echo "1) Email                     |"
echo "2) IP                        |" 
echo "3) Phone Number [INDIAN]     |"
echo "4) URL                       |"
echo "5) Extract everything        |"
echo "6) Exit                      |"
echo "-----------------------------"
echo "What you want to extract? (1/2/3/4/5)"
read choice
echo "Enter your file name:- "
read file
email() 
		{
		emails=$(cat "$file" | egrep -ow '[a-z0-9\.\_\-]*@[a-z]*\.[a-z]{2,4}(\.[a-z]{2,4})?' | sort -u)       
		count=$(cat "$file" | egrep -ow '[a-z0-9\.\_\-]*@[a-z]*\.[a-z]{2,4}(\.[a-z]{2,4})?' | sort -u | wc -l)  
		echo "------------------------------"
		echo "    $count emails are found"
		echo "------------------------------"
		nl -w2 -s ') ' <(echo "$emails")                                                           
		echo "------------------------------"
	}
IP()
{
	
		IP=$(cat "$file" | egrep -ow '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}' | sort -u)
		count=$(cat "$file" | egrep -ow '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}' | sort -u | wc -l)
	       echo "------------------------------"
	       echo " $count IP addresses are found"
	       echo "------------------------------"
	       nl -w2 -s ') ' <(echo "$IP")
	       echo "------------------------------"
       }
PHONE()
{
	PHONE=$(cat "$file" | grep -oP '[6-9]\d{9}' | sort -u )
	count=$(cat "$file" | grep -oP '[6-9]\d{9}' | sort -u | wc -l)
	echo "------------------------------"
	echo " $count Phone numbers are found"
	echo "------------------------------"
	nl -w2 -s ') ' <(echo "$PHONE")
	echo "------------------------------"
}
URL()
{
	URL=$(cat "$file" | grep -oP '(https?):\/\/?[^\s\d$.?#].[^\s]*' | sort -u)
	count=$(cat "$file" | grep -oP '(https?):\/\/?[^\s\d$.?#].[^\s]*' | sort -u | wc -l)
	echo "------------------------------"
	echo "  $count URL's are found"   
	echo "------------------------------"
	nl -w2 -s ') ' <(echo "$URL")
	echo "------------------------------"
}	
if [ -f "$file" ]
then
	case $choice in 
	1)
		email
		;;
	2)
		IP
		;;
	3)
		PHONE
		;;
	4)
		URL
		;;
	5)
		email
		IP
		PHONE
		URL
		;;
	6)
		exit
		;;
	*)	echo && echo "You have entered an option which doesn't exist in my MENU :("
esac
else
echo
echo "File doesn't exist or you have entered a wrong location :("
fi



		
