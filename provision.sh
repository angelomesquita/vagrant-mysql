#!/bin/bash
apt-get update

echo mysql-server mysql-server/root_password select "root" | debconf-set-selections
echo mysql-server mysql-server/root_password_again select "root" | debconf-set-selections

apt-get install -y mysql-server

mysql -u root -p"root" -e "use mysql; update user set host='%' where user='root' and host='localhost';"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf

service mysql restart

apt-get clean