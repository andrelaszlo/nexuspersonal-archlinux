#!/bin/bash
if [[ "$1" = "-u" ]]
then
	echo "Generating new checksum file for the current version"
	echo "Downloading file"
	wget -q https://install.bankid.com/InstallBankidCom/InstallFiles/personal-4.18.0.10751.tar.gz -O LinuxPersonal.tgz
	echo "Generating checksum file"
	md5sum LinuxPersonal.tgz > LinuxPersonal.md5
	rm LinuxPersonal.tgz
	echo "Done"
elif [[ "$1" = "-p" ]]
then
	echo "Checking page for new version"

	# old method: get download page and grep download url
	#BANKID_URL="https://install.bankid.com/sv/installbankidcom/Linuxsparet/Klientinstallation/"
	#wget -q $BANKID_URL -O pagetemp.html --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.475.0 Safari/534.3" --no-check-certificate
	#URLS=`egrep -o -a "location.href = '.*';" pagetemp.html | sed "s/location.href = '//g" | sed "s/';//g"`

	# new method: get redirection url from download page
	./getredir.expect &> /dev/null
	URLS=$(egrep -o -a "href=\".*\"" http-redir.log | egrep -o -a "href=\"[^\"]*" *.log | sed "s/href=\"//g")
	rm http-redir.log
	if [[ "$URLS" != "" ]]
	then
		echo $URLS > newurl.txt
		diff newurl.txt lasturl.txt > /dev/null
		if [ $? -eq 0 ]
		then
			echo "Still the same version"
			exit 0
		else
			echo "New version!"
			echo $URLS
    		#echo "New version of NexusPersonal available at $URLS" | mail -s "New NexusPersonal version" andre@laszlo.nu
			curl "http://andre.laszlo.nu/emailme.php?title=New%20NexusPersonal%20version&message=New%20version%20of%20NexusPersonal%20available%20at%20$URLS"
			mv newurl.txt lasturl.txt
			exit 1
		fi
	else
		echo "Something went wrong. Either you're not connected or the download url changed."
	fi
elif [[ "$1" = "-c" ]]
then
	echo "Checking for new version"
	echo "Downloading file"
	wget -q https://install.bankid.com/InstallBankidCom/InstallFiles/personal-4.18.0.10751.tar.gz -O LinuxPersonal.tgz
	echo "Testing if the online file matches"
	md5sum --status -c LinuxPersonal.md5 > /dev/null
	if [ $? -eq 0 ]
	then
		echo "Still the same version"
		exit 0
	else
		echo "New version! ($(md5sum LinuxPersonal.tgz | cut -f 1 -d " "))"
		exit 1
	fi
	rm LinuxPersonal.tgz
else
	echo -e "Checks for new versions of the BankId application (Nexus Personal)\nUsage:\n\tcheck.sh -[c|p|u|h]\n\t  c Check if there is a new version\n\t  p Check NexusPersonal page for version\n\t  u Update cached version\n\t  h Show this message"
fi
