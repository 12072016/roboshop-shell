script=$(REALPATH "$0")
script_path=$(dirname $script)
source ${script_path}/common.sh

### above is $0 is a special variable

###$0 is script name
#####realpath >>>> will give full path of the script
######dirname >>>> it will give directory of reapl script


component=user
func_nodejs

echo -e "\e[34m>>>>>>>copy mongodb repo<<<<<<<<\e[0m"

cp ${script_path}mongo.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y
echo -e "\e[34m>>>>>>>install schema<<<<<<<<\e[0m"

mongo --host mongodb-dev.kirandevops.online </app/schema/user.js