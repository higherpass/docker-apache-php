FROM phusion/baseimage
MAINTAINER Higherpass <git@higherpass.com>

# Install packages
RUN apt-get update \
  && apt-get install -y curl apache2 apache2-utils php5 php5-mysql

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure Apache
RUN mkdir -p /data/apache2/html; rm -rf /var/www/html; ln -s /data/apache2/html /var/www/html

RUN mkdir /etc/service/apache2
ADD ./scripts/apache2 /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run

EXPOSE 80

VOLUME ["/data/apache2","/etc/apache2"]
CMD ["/sbin/my_init"]
