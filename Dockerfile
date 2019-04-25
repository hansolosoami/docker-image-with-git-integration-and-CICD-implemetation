#
# fedora-apache-php
#
FROM fedora:20
MAINTAINER pushpendersingh 
# Update distribution
RUN /bin/bash -c 'yum update -y; yum clean all'

ADD redhat-rhui.repo /etc/yum.repos.d/

# Need Apache in simplest way
RUN /bin/bash -c 'yum install httpd -y; yum clean all'
RUN /bin/bash -c 'yum install git -y; yum clean all'
RUN mkdir -p /var/www/html
RUN mkdir -p /var/log/httpd

WORKDIR /var/www/html
# Create Apache test page
RUN /bin/bash -c ' git clone https://github.com/pushpendersofficial/php_sample '
RUN /bin/bash -c 'cp ./php_sample/* /var/www/html/'
# Copy apache run script
RUN /bin/bash -c 'sed -i "s/Listen 80/Listen 8080/" /etc/httpd/conf/httpd.conf'

# Done
EXPOSE 8080

ENTRYPOINT /usr/sbin/httpd -DFOREGROUND

