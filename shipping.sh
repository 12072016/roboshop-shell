SCRIPT=$(REALPATH "$0")
script_path=$(dirname $SCRIPT)
source ${script_path}/common.sh

mysql_root_password=$1
echo -e "\e[34m>>>>>>>install maven repo<<<<<<<<\e[0m"

yum install maven -y
echo -e "\e[34m>>>>>>>creat app user<<<<<<<<\e[0m"

useradd ${app_user}
echo -e "\e[34m>>>>>>>icreate app directory<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[34m>>>>>>>download app content<<<<<<<<\e[0m"

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
echo -e "\e[34m>>>>>>>unzip app content<<<<<<<<\e[0m"

cd /app
unzip /tmp/shipping.zip

echo -e "\e[34m>>>>>>>download maven dependencies<<<<<<<<\e[0m"

mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[34m>>>>>>>install mysql <<<<<<<<\e[0m"
yum install mysql -y
echo -e "\e[34m>>>>>>>load schema<<<<<<<\e[0m"
mysql -h <mysql-dev.kirandevops.online> -uroot -p${mysql_root_password} < /app/schema/shipping.sql

echo -e "\e[34m>>>>>>>setup service d file <<<<<<<<\e[0m"

cp ${script_path}/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[34m>>>>>>>start shipping service<<<<<<<<\e[0m"
systemctl daemon-reload

systemctl enable shipping
systemctl restart shipping
