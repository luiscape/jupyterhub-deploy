#!/bin/bash
#
#  Creates users based on input text file.
#
if [ $# -lt 1 ]
  then
    echo "Usage : $0 userfile"
    exit
fi

if [ $(id -u) -eq 0 ]; then

while IFS=, read username password; do

  if egrep "^$username" /etc/passwd >/dev/null;  then
      echo "$username exists!"
  else
      password=$(perl -e 'print crypt($ARGV[0], "password")' $password)

    if  useradd -m -p "$password" "$username" >/dev/null; then
          echo "User '$username' has been added to system!"
      else
          echo "Failed to add  user '$username'!"
      fi
  fi
        ln -s /opt/data /home/$username
        ln -s /opt/notebooks /home/$username
        chmod a+rwx /home/$username

done <"$@"

else
      echo "Only root may add a user to the system"
      exit
fi