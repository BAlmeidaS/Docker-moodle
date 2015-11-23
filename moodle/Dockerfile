# FROM ubuntu:14.04
FROM ubuntu:14.04

# update repositories
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# install packages
ADD ./root/packages.sh /packages.sh
RUN chmod 755 /packages.sh
RUN /packages.sh
RUN rm -f /packages.sh

# ssh settings
RUN mkdir -p /var/run/sshd

# config do mysql
VOLUME /temp/
ADD ./root/config.sh 	/temp/config.sh
ADD ./root/config/etc/mysql/my.cnf 	/temp/my.cnf
RUN chmod 755 /temp/config.sh
RUN /temp/config.sh
RUN service mysql restart

# middleware settings
ADD ./root/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./root/etc/mysql/conf.d/bind-address.cnf /etc/mysql/conf.d/bind-address.cnf

#Criacao do moodle
VOLUME /var/www/html/moodle/
VOLUME /var/moodledata/
ADD ./moodle/ /var/www/html/moodle/
ADD ./moodledata/ /var/moodledata/

RUN chown -R www-data /var/moodledata
RUN chmod -R 777 /var/moodledata
RUN chmod -R 0755 /var/www/html/moodle

#final
RUN /usr/sbin/mysqld & \
    sleep 10s &&\
    echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'pensandoai' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql

RUN chmod -R 777 /var/www/

EXPOSE 22 80

CMD ["/usr/bin/supervisord"]

