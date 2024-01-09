R="\e[31m"
G="\e[32m"
N="\e[0m"
ScriptLocation=$(pwd)

#Function to check exit-status & Validation
#function ExictStatus(){
#[[ $? -ne 0 ]] && echo -e "$R [Installing Nginx is Not done!] $N" || echo -e "$G [Installing Nginx done successfully] $N"
#}

# Installing Nginx
echo -e "[Installing Nginx].."
dnf install nginx -y > /dev/null
[[ $? -ne 0 ]] && echo -e "$R [Installing Nginx is Not done!] $N" || echo -e "$G [Installing Nginx done successfully] $N"


# Removing files in /usr/share/nginx/html/*
rm -rf /usr/share/nginx/html/* 
[[ $? -ne 0 ]] && echo -e "$R [Removing file in /usr/share/nginx/html/* is not done failure ] $N" || echo -e "$G [ Removing file in /usr/share/nginx/html/* is done successfully] $N"

#Downloading files of source-code

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
[[ $? -ne 0 ]] && echo -e "$R [Removing file in /usr/share/nginx/html/* is not done failure ] $N" || echo -e "$G [ Removing file in /usr/share/nginx/html/* is done successfully] $N"

#unziping files

unzip /tmp/frontend.zip -d /usr/share/nginx/html/
[[ $? -ne 0 ]] && echo -e "$R [Removing file in /usr/share/nginx/html/* is not done failure ] $N" || echo -e "$G [ Removing file in /usr/share/nginx/html/* is done successfully] $N"

#copying configuration file
cp ${pwd}/files/nginx.conf /etc/nginx/default.d/roboshop.conf
[[ $? -ne 0 ]] && echo -e "$R [Removing file in /usr/share/nginx/html/* is not done failure ] $N" || echo -e "$G [ Removing file in /usr/share/nginx/html/* is done successfully] $N"

#Starting Nginx Server
systemctl start nginx
systemctl enable nginx 

systemctl restart nginx 
[[ $? -ne 0 ]] && echo -e "$R [Removing file in /usr/share/nginx/html/* is not done failure ] $N" || echo -e "$G [ Removing file in /usr/share/nginx/html/* is done successfully] $N"
