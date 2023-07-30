
echo -e "\e[36m>>>>>>>disable my sql default 8 version<<<<<<<<\e[0m"
dnf module disable mysql -y
echo -e "\e[36m>>>>>>>coping my sql repo file<<<<<<<<\e[0m"

cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[36m>>>>>>>install my sql<<<<<<<<\e[0m"
yum install mysql-community-server -y

echo -e "\e[36m>>>>>>>starting my sql <<<<<<<<\e[0m"

systemctl enable mysqld
systemctl restart mysqld
echo -e "\e[36m>>>>>>>reset my sql password<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
