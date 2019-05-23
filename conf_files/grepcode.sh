dpkg -l | grep -q "openssh-server"
if [[ $? != 0 ]]; then
	echo "User does not exist!!"
fi
