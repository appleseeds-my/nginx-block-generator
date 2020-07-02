code="$1"
site="$1.origin"
path="$HOME/Projects/$1$2"
phpver="$3"
phpport="90${phpver/\./}"

rm -f "/usr/local/etc/nginx/ssl/$code.crt";
rm -f "/usr/local/etc/nginx/ssl/$code.key";

sed -i '' -e -E "s/(subjectAltName)(.*)/\1\2, DNS:www.$site/g" /usr/local/etc/nginx/ssl/openssl.cnf
sudo openssl dhparam -out /usr/local/etc/nginx/ssl/dhparam.pem 128;

sudo openssl req \
  -x509 -nodes -days 365 -newkey rsa:2048 \
  -subj "/CN=www.{$site}" \
  -config /usr/local/etc/nginx/ssl/openssl.cnf \
  -keyout "/usr/local/etc/nginx/ssl/$code.key" \
  -out "/usr/local/etc/nginx/ssl/$code.crt"

sudo security add-trusted-cert \
  -d -r trustRoot \
  -k /Library/Keychains/System.keychain "/usr/local/etc/nginx/ssl/$code.crt"

cp block.conf "temp/$1"
sed -i '' -e "s/{code}/$1/g" "temp/$code"
sed -i '' -e "s/{site}/$site/g" "temp/$code"
sed -i '' -e "s+{path}+$path+g" "temp/$code"
sed -i '' -e "s/{phpport}/$phpport/g" "temp/$code"

mv "temp/$1" "/usr/local/etc/nginx/servers/$code"

nginx -s reload