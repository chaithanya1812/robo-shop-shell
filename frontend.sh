R="\e[31"
G="\e[32"
N="\e[0m"
echo -e "[Installing Nginx].."
dnf install nginx -y > /dev/null
[[ $? -ne 0 ]] && echo -e "$R [Installing Nginx is Not done!] $N" || echo -e "$G [Installing Nginx done successfully] $N"
