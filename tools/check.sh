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
	echo -e "Checks for new versions of the BankId application (Nexus Personal)\nUsage:\n\tcheck.sh -[c|u|h]\n\t  c Check if there is a new version\n\t  u Update cached version\n\t  h Show this message"
fi
