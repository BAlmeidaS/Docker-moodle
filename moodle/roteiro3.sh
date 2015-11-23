#/bin/bash

docker run -d -p 8007:80 -p 3308:3306 -p 22:22 --link mysql:db -v /home/ubuntu/moodle/moodledata:/var/moodledata/ moodletccpoli

sudo chmod 777 -R /home/ubuntu/moodle/moodle

TAG="mysql"
CONTAINER_ID=$(docker ps | grep $TAG | awk '{print $1}')
IP=$(docker inspect $CONTAINER_ID | python -c 'import json,sys;obj=json.load(sys.stdin);print obj[0]["NetworkSettings"]["IPAddress"]')

printf "%s\n" $IP

exit

