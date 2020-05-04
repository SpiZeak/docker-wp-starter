#!/bin/bash

# Install Bedrock, Wordpress and plugin dependencies
(cd ../../../../ && composer install)

# Install Sage dependencies
composer install

# Install Node packages with Yarn
npm install yarn --no-package-lock && npx yarn

# Stop all running containers
docker stop $(docker ps -a -q)

# Run Docker containers and start development server
(cd ../../../../../ && docker-compose up -d)

# Start development server
npx yarn start
