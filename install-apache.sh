#! /bin/bash

  yum install httpd -y
  chkconfig httpd on
  echo "<h1>Deployed by terraform </h1>" > /var/www/html/index.html
  service httpd start
