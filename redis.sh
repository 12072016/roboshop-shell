echo -e "\e[34m>>>>>>>install redis repo<<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[34m>>>>>>>enable redis repo<<<<<<<<\e[0m"
dnf module enable redis:remi-6.2 -y

yum install redis -y

####Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis.conf & /etc/redis/redis.conf

sed -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf
echo -e "\e[34m>>>>>>>start redis <<<<<<<<\e[0m"
systemctl enable redis
systemctl start redis