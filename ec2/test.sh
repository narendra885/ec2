#!/bin/bash
sudo sudo
apt install apache2 -y
systemctl start apache2
echo "<h1>Welocme to tf test</h1>" > /var/www/html/index.html



