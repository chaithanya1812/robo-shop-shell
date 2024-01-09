R="\e[31m"
G="\e[32m"
N="\e[0m"
ScriptLocation=$(pwd)

dnf module disable nodejs -y > /dev/null 
dnf module enable nodejs:18 -y > /dev/null 

dnf install nodejs -y > /dev/null

[[ $? -ne 0 ]] && echo -e "$R [ Installing Nodejs is failure ] $N" || echo -e "$G [ Installing Nodejs is done successfully] $N" 

#-Add application User
useradd roboshop

#- creating directory
mkdir -p /app 

#-Downloading source files
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  &>/dev/null

unzip /tmp/catalogue.zip -d ${ScriptLocation}/app/

cd ${ScriptLocation}/app 
npm install 

echo '
[Unit]
Description = Catalogue Service

[Service]
User=roboshop
Environment=MONGO=true
Environment=MONGO_URL="mongodb://<MONGODB-SERVER-IPADDRESS>:27017/catalogue"
ExecStart=/bin/node /app/server.js
SyslogIdentifier=catalogue

[Install]
WantedBy=multi-user.target 
' > /etc/systemd/system/catalogue.service

sed -i -e 's/<MONGODB-SERVER-IPADDRESS>/localhost/' /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue 
systemctl start catalogue
dnf install mongodb-org-shell -y


mongo --host MONGODB-SERVER-IPADDRESS < ${ScriptLocation}/app/schema/catalogue.js
