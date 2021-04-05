#!/bin/bash

#Denna bash script söker efter alla noder som är uppe i en nätverk 
#sedan nmap skanna dom och skickar resultaten till en fil.

# Fråga användare att knappa in subnet, första och sista host
echo "Skriv en Subnet"
read SUBNET
echo "Första Noden: "
read FIRST
echo "Sista Noden: "
read LAST

# for loop för att iterera genom alla angivna noder
for IP in $(seq $FIRST $LAST)
do
	#Pinga noder och skicka resultaten till null filen 
	#så att vi inte behöver se det på skärmen.
	ping -c 1 $SUBNET.$IP > /dev/null

	#Om noden är uppe så börjar nmap skanning för den.
	if [ "$?" = 0 ] # $? är tidigare operation och 0 är ett positivt resultat från ping.
	then
		echo "Nu börjar Nmap skanning för noder som är uppe."
		echo "$SUBNET.$IP Var god vänta.."
		#Resultaten från nmap lagras i en text fil.
		nmap -Pn $SUBNET.$IP >> Nmapresult.txt
	fi
done

