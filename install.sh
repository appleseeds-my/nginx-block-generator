
brew install mariadb;

brew install dnsmasq
cp dnsmasq.conf /usr/local/etc/dnsmasq.d/development.conf

brew install nginx;
rm -rf /usr/local/etc/nginx/ssl/*;
mkdir /usr/local/etc/nginx/ssl/;
cp /System/Library/OpenSSL/openssl.cnf /usr/local/etc/nginx/ssl/openssl.cnf;
echo "\n\n[v3_ca]\nsubjectAltName = DNS:localhost" >> /usr/local/etc/nginx/ssl/openssl.cnf

brew install php@7.4
sed -i '' -e 's/127.0.0.1:9000/127.0.0.1:9074/g' /usr/local/etc/php/7.4/php-fpm.d/www.conf
brew services restart php@7.4

brew install php@7.3
sed -i '' -e 's/127.0.0.1:9000/127.0.0.1:9073/g' /usr/local/etc/php/7.3/php-fpm.d/www.conf
brew services restart php@7.3

brew install php@7.2
sed -i '' -e 's/127.0.0.1:9000/127.0.0.1:9072/g' /usr/local/etc/php/7.2/php-fpm.d/www.conf
brew services restart php@7.2

brew tap exolnet/homebrew-deprecated
brew install php@5.6
sed -i '' -e 's/127.0.0.1:9000/127.0.0.1:9056/g' /usr/local/etc/php/5.6/php-fpm.conf
brew services restart php@5.6
