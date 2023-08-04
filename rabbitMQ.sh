script=$(REALPATH "$0")
script_path=$(dirname $script)
source ${script_path}/common.sh

rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password" ];then
  echo Input roboshop appuser password missing
  exit
fi

echo -e "\e[36m>>>>>>>setup earlang repos <<<<<<<<\e[0m"


curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[36m>>>>>>>setup rabbitmq repos<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[36m>>>>>>>install rabbitmq and erlang <<<<<<<<\e[0m"
yum install erlang rabbitmq-server -y



echo -e "\e[36m>>>>>>>start rabbirtmq <<<<<<<<\e[0m"


systemctl enable rabbitmq-server
systemctl restart rabbitmq-server

echo -e "\e[36m>>>>>>>add application user in rabbit mq<<<<<<<<\e[0m"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"