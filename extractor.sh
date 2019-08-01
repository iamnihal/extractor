#!/bin/bash    

email() 
{
	emails=$(cat "$file" | grep -Eow '[a-z0-9\.\_\-]*@[a-z]*\.[a-z]{2,4}(\.[a-z]{2,4})?' | sort -u)       
	count=$(cat "$file" | grep -Eow '[a-z0-9\.\_\-]*@[a-z]*\.[a-z]{2,4}(\.[a-z]{2,4})?' | sort -u | wc -l)  
	echo "------------------------------"
	echo "    $count emails are found"
	echo "------------------------------"
	output1=$(nl -w2 -s ') ' <(echo "$emails"))
	echo "$output1" 
	echo "------------------------------"
}
IP()
{

	IP=$(cat "$file" | grep -Eow '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}' | sort -u)
	count=$(cat "$file" | grep -Eow '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}' | sort -u | wc -l)
	echo "------------------------------"
	echo " $count IP addresses are found"
	echo "------------------------------"
	output2=$(nl -w2 -s ') ' <(echo "$IP"))
	echo "$output2"
	echo "------------------------------"
}
PHONE()
{
	PHONE=$(cat "$file" | grep -EoP '[6-9]\d{9}' | sort -u )
	count=$(cat "$file" | grep -EoP '[6-9]\d{9}' | sort -u | wc -l)
	echo "------------------------------"
	echo " $count Phone numbers are found"
	echo "------------------------------"
	output3=$(nl -w2 -s ') ' <(echo "$PHONE"))
	echo "$output3"
	echo "------------------------------"
}
URL()
{
	URL=$(cat "$file" | grep -oP '(https?):\/\/?[^\s\d$.?#].[^\s]*' | sort -u)
	count=$(cat "$file" | grep -oP '(https?):\/\/?[^\s\d$.?#].[^\s]*' | sort -u | wc -l)
	echo "------------------------------"
	echo "  $count URL's are found"   
	echo "------------------------------"
	output4=$(nl -w2 -s ') ' <(echo "$URL"))
	echo "$output4"
	echo "------------------------------"
}
logo()
{
	cat <<"EOT"
		 _____      _                  _             
		| ____|_  _| |_ _ __ __ _  ___| |_ ___  _ __ 
		|  _| \ \/ / __| '__/ _` |/ __| __/ _ \| '__|
		| |___ >  <| |_| | | (_| | (__| || (_) | |   
		|_____/_/\_\\__|_|  \__,_|\___|\__\___/|_|   

							 with <3 by Nihal
EOT
}
menu()
{
	echo -e "\033[1;31m-----------------------------" 
	echo -e "\033[1;31m            MENU             |"
	echo -e "\033[1;31m-----------------------------|"
	echo -e "\033[1;31m1) Email                     |"
	echo -e "\033[1;31m2) IP                        |" 
	echo -e "\033[1;31m3) Phone Number [INDIAN]     |"
	echo -e "\033[1;31m4) URL                       |"
	echo -e "\033[1;31m5) Extract everything        |"
	echo -e "\033[1;31m6) Exit                      |"
	echo -e "\033[1;31m------------------------------"
	echo -e "\033[1;33m\nWhat you want to extract? (1/2/3/4/5/6)"
	read choice
	if [ "$choice" -eq 1 ] || [ "$choice" -eq 2 ] || [ "$choice" -eq 3 ] || [ "$choice" -eq 4 ] || [ "$choice" -eq 5 ]
	then
		echo -e "\nEnter your file name:- "
		read file
	else
		if [ "$choice" -eq 6 ]
		then
			exit
		fi

		echo -e "\033[1;34m\nYou have entered \"$choice\" which isn't a choice :(\nPlease try again with a valid choice."
		exit 0
	fi
}

email_output()
{
	touch ./output/email.txt
	sed -i '/Latest/d' ./output/email.txt
	sed -i '/------------------------------/d' ./output/email.txt
	echo -e "-----------------------------" >> ./output/email.txt
	echo -e "\tLatest\n------------------------------" >> ./output/email.txt
	echo "$output1" >> ./output/email.txt
	echo "------------------------------" >> ./output/email.txt
}

ip_output()
{	
	touch ./output/ip.txt
	sed -i '/Latest/d' ./output/ip.txt
	sed -i '/------------------------------/d' ./output/ip.txt
	echo -e "-----------------------------" >> ./output/ip.txt
	echo -e "\tLatest\n------------------------------" >> ./output/ip.txt
	echo "$output2" >> ./output/ip.txt
	echo "------------------------------" >> ./output/ip.txt
}

phone_output()
{
	touch ./output/phone.txt
	sed -i '/Latest/d' ./output/phone.txt
	sed -i '/------------------------------/d' ./output/phone.txt
	echo -e "-----------------------------" >> ./output/phone.txt
	echo -e "\tLatest\n------------------------------" >> ./output/phone.txt
	echo "$output3" >> ./output/phone.txt
	echo "------------------------------" >> ./output/phone.txt
}

url_output()
{
	touch ./output/url.txt
	sed -i '/Latest/d' ./output/url.txt
	sed -i '/------------------------------/d' ./output/url.txt
	echo -e "-----------------------------" >> ./output/url.txt
	echo -e "\tLatest\n------------------------------" >> ./output/url.txt
	echo "$output4" >> ./output/url.txt
	echo "------------------------------" >> ./output/url.txt
}

output()
{
	if [ "$choice" -eq 1 ]
	then
		email_output
	elif [ "$choice" -eq 2 ]
	then
		ip_output
	elif [ "$choice" -eq 3 ]
	then
		phone_output
	elif [ "$choice" -eq 4 ]
	then
		url_output
	else
		email_output
		ip_output
		phone_output
		url_output
	fi
}
main()
{
	clear
	logo
	mkdir -p ./output/
	menu

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
		esac
	else
		echo -e "\033[1;34mFile doesn't exist or you have entered a wrong location :("
		exit
	fi
	echo "Would you like to save the output? (Y/N)"
	read choice2
	if [ $choice2 == "Y" ] || [ $choice2 == "y" ]
	then
		output
		echo "Output has been successfully saved!"
	elif [ $choice2 == "N" ] || [ $choice2 == "n" ]
	then
		echo "Hope to see you soon!"
	else
		echo "Choice Error!"
	fi
}
main
