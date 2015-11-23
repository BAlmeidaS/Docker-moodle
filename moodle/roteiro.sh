#/bin/bash

scp -i "Moodle.pem" /home/bruno/Desktop/DOCKER/moodle ec2-user@54.213.243.151:/tcc/

ssh -i "Moodle.pem" ec2-user@54.213.243.151

cd /tcc

git clone -b MOODLE_29_STABLE https://github.com/moodle/moodle
mkdir moodledata

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
#docker rmi $(docker images -a -q)

docker build -t moodletccpoli .

#config mysql
mkdir /home/admin/moodledata
docker run --name mysql -v /home/admin/moodledata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD="pensandoai" -d mysql

docker exec mysql mysql -u root -ppensandoai << EOF
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
create user 'moodle'@'localhost' IDENTIFIED BY 'pensandoai';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO moodle@localhost IDENTIFIED BY 'pensandoai';
EOF

docker run -d -p 8007:80 -p 3308:3306 -p 22:22 --link mysql:db -v /home/bruno/Desktop/DOCKER/moodle/moodle:/var/www/html/moodle/ -v /home/bruno/Desktop/DOCKER/moodle/moodledata:/var/moodledata/ moodletccpoli

sudo chmod 777 -R /home/bruno/Desktop/DOCKER/moodle

TAG="mysql"
CONTAINER_ID=$(docker ps | grep $TAG | awk '{print $1}')
IP=$(docker inspect $CONTAINER_ID | python -c 'import json,sys;obj=json.load(sys.stdin);print obj[0]["NetworkSettings"]["IPAddress"]')
printf "%s\n" $IP

exit

