#!/bin/bash

set -e

echo -ne '\n\033[0;37mInstalling Bedrock, Wordpress and plugin dependencies with Composer ... '
(cd ../../../../ && composer install  --quiet --no-interaction)
echo -ne '\033[0;32mdone'

echo -ne '\n\033[0;37mInstalling Sage dependencies with Composer ... '
composer install --quiet --no-interaction
echo -ne '\033[0;32mdone'

echo -ne '\n\033[0;37mInstalling Node packages with Yarn ... '
(npm install yarn --quiet --no-audit --no-package-lock && npx yarn --silent) > /dev/null 2>&1
echo -ne '\033[0;32mdone'

echo -ne '\n\033[0;37mStopping all running Docker containers ... '
docker stop $(docker ps -a -q) > /dev/null 2>&1
echo -ne '\033[0;32mdone\033[0;37m\n'

# Run Docker containers and start development server
(cd ../../../../../ && docker-compose up -d)

# Start development server
npx --no-install --quiet yarn start
