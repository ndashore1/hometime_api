# README

# Hometime api coding challenge
## Dependencies
* Ruby version : 2.7.2
* Rails Version : 6.1.4

## Setup with Docker

### Prerequisites

* Docker
### Setup

```
$ docker-compose up
$ docker-compose run web rake db:create db:migrate db:seed
$ docker-compose run web rspec
```
## Local Setup

## Configurations
```gem install bundler && bundle install```

## Setup and Start the Applicaton
### Database Setup
```rake db:create db:migrate && rake db:seed```
### Run the rails server
```rails s```
## Test Environment Setup
### Test Database Setup
```RAILS_ENV=test rake db:create && RAILS_ENV=test rake db:migrate```
### Run the Test Suit
```rspec```

## Postman Collection
* Added file on root directory hometime_api.postman_collection.json

## Assumptions
* When payload contains existing reservation code then reservation will be updated.