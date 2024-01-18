R="\e[31m"
G="\e[32m"
N="\e[0m"
ScriptLocation=$(pwd)
LogFile="/tmp/roboshop.log"

function status_check() {
if [ $1 -ne 0 ]; then
echo "${R} $2 is failed ${N}"
echo "${R} Check the log-file in ${LogFile}"
else
echo "${R} $2 is failed ${N}"
fi
}

function print_head() {
echo "{G} $1 {N}"
}

print_head "Redis is offering the repo file as a rpm"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> ${LogFile}

status_check $? "Redis is offering the repo file as a rpm"

