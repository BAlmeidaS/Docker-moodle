#/bin/bash
ssh -i "moodletcc.pem" ubuntu@54.213.243.188 << EOF

docker run -d -p 80:80 -p 3306:3306 -p 24:22 --link mysql:mysql -v /home/ubuntu/moodle/moodledata:/var/moodledata/ -v /home/ubuntu/moodle/moodle:/var/www/html/moodle/ moodletccpoli

sudo chmod 777 -R /home/ubuntu/moodle

#TAG="mysql"
#CONTAINER_ID=$(docker ps | grep $TAG | awk '{print $1}')
#IP=$(docker inspect $CONTAINER_ID | python -c 'import json,sys;obj=json.load(sys.stdin);print obj[0]["NetworkSettings"]["IPAddress"]')
#printf "%s\n" $IP

exit

EOF
