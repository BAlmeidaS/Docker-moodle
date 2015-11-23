ssh -i "moodletcc.pem" ubuntu@54.213.243.188 << EOF

cd /home/ubuntu/moodle
git clone -b MOODLE_29_STABLE https://github.com/moodle/moodle && sleep 15
mkdir moodledata

exit

EOF