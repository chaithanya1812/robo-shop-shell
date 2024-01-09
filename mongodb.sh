#- Setup the MongoDB repo file

ScriptLocation=${pwd}
echo "[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc" >/etc/yum.repos.d/mongodb-org-4.2.repo
[[ $? -ne 0 ]] && echo -e "$R [Setup the MongoDB repo file is failure ] $N" || echo -e "$G [Setup the MongoDB repo file is done successfully] $N"
#-Install MongoDB
dnf install mongodb-org -y 
[[ $? -ne 0 ]] && echo -e "$R [ Install MongoDB is failure ] $N" || echo -e "$G [Install MongoDB is done successfully] $N"

#-Start & Enable MongoDB Service
systemctl start mongod 
[[ $? -ne 0 ]] && echo -e "$R [ Starting MongoDB is failure ] $N" || echo -e "$G [Starting MongoDB is done successfully] $N"

systemctl enable mongod 
[[ $? -ne 0 ]] && echo -e "$R [ Enable MongoDB is failure ] $N" || echo -e "$G [ Enable MongoDB is done successfully] $N"


