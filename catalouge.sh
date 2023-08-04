script=$(REALPATH "$0")
script_path=$(dirname $script)
source ${script_path}/common.sh

component=catalouge
func_nodejs


echo -e "\e[34m>>>>>>>copy mongodb repo <<<<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[34m>>>>>>>install mongodb client<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[34m>>>>>>>load schema<<<<<<<<\e[0m"
mongo --host mongodb-dev.kirandevops.online </app/schema/catalogue.js

