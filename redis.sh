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
echo -e "${R} $2 is successfull ${N}"
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

