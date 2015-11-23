ssh -i "moodletcc.pem" ubuntu@54.213.243.188 << EOF

#PRSI=$(docker ps -q)
#PRST=$(docker ps -a -q)
#IMGS=$(docker images -a -q)
#docker stop $PRSI
#docker rm $PRST 
#docker rmi $IMGS
docker build -t moodletccpoli /home/ubuntu/moodle
exit

EOF