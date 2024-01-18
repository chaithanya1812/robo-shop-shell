R="\e[31m"
G="\e[32m"
N="\e[0m"
ScriptLocation=$(pwd)

function status_check() {
if [ $? -ne 0 ]; then
echo "$R $2 is failed ${N}"
else
echo "$R $2 is failed ${N}"
}
