#####adding variable for user

app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")


#### all the common imp things we will keep it in a file and when ever its required we will import this file
## keep our code dry we can modify this paths and directories:

script=$(realpath "$0")
script_path=$(dirname "$script")
