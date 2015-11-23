#/bin/bash

docker exec mysql mysql -u root -ppensandoai << EOF
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
create user 'moodle'@'localhost' IDENTIFIED BY 'pensandoai';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO moodle@localhost IDENTIFIED BY 'pensandoai';
EOF

