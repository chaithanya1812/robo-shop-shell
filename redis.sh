R="\e[31m"
G="\e[32m"
N="\e[0m"
ScriptLocation=$(pwd)
LogFile="/tmp/roboshop.log"

function status_check() {
if [ $1 -ne 0 ]; then
echo -e "${R} $2 is failed ${N}"
echo -e "${R} Check the log-file in ${LogFile}"
else
echo -e "${G} $2 is successfull ${N}"
fi
}

function print_head() {
echo -e "${G} $1 ${N}"
}

print_head "Redis is offering the repo file as a rpm"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> ${LogFile}

status_check $? "Redis is offering the repo file as a rpm"

print_head "Enable Redis 6.2 from package streams."

dnf module enable redis:remi-6.2 -y &>> ${LogFile}
status_check $? "Enable Redis 6.2 from package streams."

 print_head "Install Redis"
 dnf install redis -y  &>> ${LogFile}
 status_check $? "Install Redis"
print_head "Update listen address from 127.0.0.1 to 0.0.0.0"
sed -i  '/^bind/ s/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf 
status_check $? "Update listen address from 127.0.0.1 to 0.0.0.0"

print_head "Update listen address from 127.0.0.1 to 0.0.0.0"
sed -i  '/^bind/ s/127.0.0.1/0.0.0.0/' /etc/redis.conf
status_check $? "Update listen address from 127.0.0.1 to 0.0.0.0"

print_head "Start & Enable Redis Service"
systemctl start redis
systemctl enable redis 
status_check $? "Start & Enable Redis Service" 


