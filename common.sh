#####adding variable for user

app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")


#### all the common imp things we will keep it in a file and when ever its required we will import this file
## keep our code dry we can modify this paths and directories:

###script=$(realpath "$0")
####script_path=$(dirname "$script")



#####function
func_noejs(){echo -e "\e[36m>>>>>>>configuring nodejs repo<<<<<<<<\e[0m"

             curl -sL https://rpm.nodesource.com/setup_lts.x | bash
             echo -e "\e[36m>>>>>>>install nodejs repo<<<<<<<<\e[0m"
             yum install nodejs -y
             echo -e "\e[36m>>>>>>>adding app user<<<<<<<<\e[0m"
             useradd ${app_user}
             echo -e "\e[36m>>>>>>>creating app directory <<<<<<<<\e[0m"
             rm -rf /app
             mkdir /app
             echo -e "\e[36m>>>>>>>downloading app content<<<<<<<<\e[0m"
             curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

             cd /app
             echo -e "\e[36m>>>>>>>unzip app content<<<<<<<<\e[0m"
             unzip /tmp/${component}.zip

             echo -e "\e[36m>>>>>>>downloading app dependencies<<<<<<<<\e[0m"
             npm install
             echo -e "\e[36m>>>>>>>creating app directory<<<<<<<<\e[0m"
             cp ${script_path}/cart.service /etc/systemd/system/${component}.service

             echo -e "\e[36m>>>>>>>starting cart service<<<<<<<<\e[0m"

             systemctl daemon-reload


             systemctl enable ${component}
             systemctl restart ${component}
             }