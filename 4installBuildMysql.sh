ssh -i "moodletcc.pem" ubuntu@54.213.243.188 << EOF

#config mysql
#docker run --name mysql -v /home/ubuntu/moodledata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD="pensandoai" -d mysql
sleep 15
docker exec mysql mysql -u root -ppensandoai  << EOFSQL
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
create user 'admin'@'localhost' IDENTIFIED BY 'pensandoai';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO admin@localhost IDENTIFIED BY 'pensandoai';
EOFSQL

exit

EOF