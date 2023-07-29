echo -e "\e[34m>>>>>>>configuring user repo<<<<<<<<\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34m>>>>>>>install nodejs repo<<<<<<<<\e[0m"

yum install nodejs -y
echo -e "\e[34m>>>>>>>add application user <<<<<<<<\e[0m"

useradd roboshop
echo -e "\e[34m>>>>>>>add application directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[34m>>>>>>>download app content<<<<<<<<\e[0m"

curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
echo -e "\e[34m>>>>>>>unzip nodejs <<<<<<<<\e[0m"

unzip /tmp/user.zip

echo -e "\e[34m>>>>>>>install dependencies nodejs repo<<<<<<<<\e[0m"

npm install

echo -e "\e[34m>>>>>>>copy user servoce file<<<<<<<<\e[0m"

cp /home/roboshop-shell/user.service /etc/systemd/system/user.service


echo -e "\e[34m>>>>>>>start  user<<<<<<<<\e[0m"

systemctl daemon-reload


systemctl enable user
systemctl start user

echo -e "\e[34m>>>>>>>copy mongodb repo<<<<<<<<\e[0m"

cp /home/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y
echo -e "\e[34m>>>>>>>install schema<<<<<<<<\e[0m"

mongo --host mongodb-dev.kirandevops.online </app/schema/user.js