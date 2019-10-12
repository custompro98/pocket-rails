# Pocket Rails
A Pocket clone written soley as a Rails 5 API.

[![Build Status](https://travis-ci.org/custompro98/pocket-rails.svg?branch=master)](https://travis-ci.org/custompro98/pocket-rails)
[![Test Coverage](https://api.codeclimate.com/v1/badges/8a9b7d6ca90ef6665cf0/test_coverage)](https://codeclimate.com/github/custompro98/pocket-rails/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/8a9b7d6ca90ef6665cf0/maintainability)](https://codeclimate.com/github/custompro98/pocket-rails/maintainability)

## API Documentation
To view the API docs go to the [ApiaryIO Site](https://pocketrails.docs.apiary.io/)

## Demo
You can practice hitting the API on the [staging site](https://secret-lake-48253.herokuapp.com)

## Development
_This guide assumes you have docker-compose installed on your system_

To set up your environment: `bin/init`

### Services provided
#### Web
This service starts the Rails server or execute arbitrary rails tasks in the development Rails environment
_localhost:80 is forwarded to localhost:3000_

Starting the server: `docker-compose up -d`
Attaching to the server: `docker attach <container>`
Running rails tasks: `docker-compose run web rails task:name`
Running RSpec: `docker-compose run web rspec path/to/test`

####  Postgres
This service is the datastore, uses the default Postgres image
_localhost:5432 is exposed for direct db access_