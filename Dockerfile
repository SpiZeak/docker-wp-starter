FROM ubuntu:latest
LABEL Max Trewhitt max@trewhitt.se
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install git && \
	apt-get -y install curl && \
	apt-get -y install zip && \
	apt-get -y install unzip && \
	apt-get -y install php && \
	apt-get -y install php-xml

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html
RUN rm index.html
COPY /html /var/www/html

# Install Bedrock dependencies
CMD composer install --no-interaction --optimize-autoloader
