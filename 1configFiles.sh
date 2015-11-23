ssh -i "moodletcc.pem" ubuntu@54.213.243.188 << EOF
	sudo rm -rf moodle
	mkdir moodle
	exit
EOF
