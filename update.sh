code="$1"
site="$1.origin"
path="$HOME/Projects/$1$2"
phpver="$3"
phpport="90${phpver/\./}"

cp block.conf "temp/$1"
sed -i '' -e "s/{code}/$1/g" "temp/$code"
sed -i '' -e "s/{site}/$site/g" "temp/$code"
sed -i '' -e "s+{path}+$path+g" "temp/$code"
sed -i '' -e "s/{phpport}/$phpport/g" "temp/$code"

mv "temp/$1" "/usr/local/etc/nginx/servers/$code"

nginx -s reload