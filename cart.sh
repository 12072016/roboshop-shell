echo -e "\e[36m>>>>>>>configuring nodejs repo<<<<<<<<\e[0m"

curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m>>>>>>>install nodejs repo<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[36m>>>>>>>adding app user<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[36m>>>>>>>creating app directory <<<<<<<<\e[0m"
mkdir /app
echo -e "\e[36m>>>>>>>downloading app content<<<<<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip

cd /app
echo -e "\e[36m>>>>>>>unzip app content<<<<<<<<\e[0m"
unzip /tmp/cart.zip

echo -e "\e[36m>>>>>>>downloading app dependencies<<<<<<<<\e[0m"
npm install
echo -e "\e[36m>>>>>>>creating app directory<<<<<<<<\e[0m"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[36m>>>>>>>starting cart service<<<<<<<<\e[0m"

systemctl daemon-reload


systemctl enable cart
systemctl start cart

