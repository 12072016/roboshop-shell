echo -e "\e[34m>>>>>>>configuring nodejs repo<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34m>>>>>>>install nodejs repo<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[34m>>>>>>>add application user<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[34m>>>>>>>create application directory<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[34m>>>>>>>download app content<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[34m>>>>>>>unzip app content<<<<<<<<\e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[34m>>>>>>>install nodejs dependensies <<<<<<<<\e[0m"

npm install
echo -e "\e[34m>>>>>>>copy catalouge systemd file<<<<<<<<\e[0m"
cp catalouge.service /etc/systemd/system/catalogue.service
echo -e "\e[34m>>>>>>>start catalouge service<<<<<<<<\e[0m"
systemctl daemon-reload


systemctl enable catalogue
systemctl start catalogue
systemctl restart catalogue
echo -e "\e[34m>>>>>>>copy mongodb repo <<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[34m>>>>>>>install mongodb client<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[34m>>>>>>>load schema<<<<<<<<\e[0m"
mongo --host mongodb-dev.kirandevops.online </app/schema/catalogue.js

