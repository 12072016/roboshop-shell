SCRIPT=$(REALPATH "$0")
script_path=$(dirname $SCRIPT)
source ${script_path}/common.sh
mysql_root_password=$1
echo -e "\e[34m>>>>>>>install python<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[34m>>>>>>>add app user<<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[34m>>>>>>>create app directory<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[34m>>>>>>>download app content<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
echo -e "\e[34m>>>>>>>extract app content <<<<<<<<\e[0m"
cd /app
unzip /tmp/payment.zip
echo -e "\e[34m>>>>>>>install dependensis<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt
echo -e "\e[34m>>>>>>>copy and setup service file<<<<<<<<\e[0m"
cp ${script_path}/payment.service /etc/systemd/system/payment.service

echo -e "\e[34m>>>>>>>start payment service<<<<<<<<\e[0m"
systemctl daemon-reload

systemctl enable payment
systemctl restart payment