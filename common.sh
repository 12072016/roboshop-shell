#####adding variable for user

app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")


#### all the common imp things we will keep it in a file and when ever its required we will import this file
## keep our code dry we can modify this paths and directories:

###script=$(realpath "$0")
####script_path=$(dirname "$script")

print_head() {
  echo -e "\e[34m>>>>>>>$*<<<<<<<<\e[0m"
}

schema_setup(){
 if [ "$schema_setup" == "mongo" ]; then
  print_head "copy mongodb repo"

  cp ${script_path}mongo.repo /etc/yum.repos.d/mongo.repo
print_head "install mongodb Client"
  yum install mongodb-org-shell -y
  print_head "install schema"

  mongo --host mongodb-dev.kirandevops.online </app/schema/$component.js
  fi
}

#####function
func_nodejs()  {   print_head "configuring nodejs repo"

             curl -sL https://rpm.nodesource.com/setup_lts.x | bash
              print_head "install nodejs repo"
             yum install nodejs -y
             print_head "adding app user"
             useradd ${app_user}
             print_head "creating app directory"
             rm -rf /app
             mkdir /app
             print_head "downloading app content"
             curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

             cd /app
             print_head "unzip app content"
             unzip /tmp/${component}.zip

             print_head "downloading app dependencies"
             npm install
             print_head "creating app directory"
             cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

              print_head "starting cart service"

             systemctl daemon-reload


             systemctl enable ${component}
             systemctl restart ${component}
             schema_setup
             }