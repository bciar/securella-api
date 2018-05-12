# Securella Backend

This project contains the securela backend. This is a Ruby on Rails 5 API only project.

We use these tutorials as inspiration:

* https://sourcey.com/building-the-prefect-rails-5-api-only-app/
* https://github.com/lynndylanhurley/devise_token_auth
* https://j-toker-demo.herokuapp.com/#/

## Quickstart

You need
* docker & docker-compose
* ruby 2.3.3

Build the environment: `docker-compose build`

Start the environment: `docker-compose up`

## Daily work environment

To do this, you have to setup your box once. See instructions below.

* In your terminal run `docker-compose up`
  * This should start the following Services:
  * Rails Backend: http://localhost:3000/ (no frontend: Use curl to access)
  * React Frontend: http://localhost:3001/
  * Mailcatcher: http://localhost:1080/

* Working with the Rails container
  * Run `docker-compose exec securella-api bash`
  * Do everything in the container
  * Run tests: `rspec`
  * Run linter : `rubocop`
  * Start guard as monitoring service `guard`

* Working with the React container
  * Run `docker-compose exec securella-web bash`
  * Do everything in the container

## Setup your local machine


#### System dependencies

* rbenv installed: Use ruby version 2.3.3
* Docker


#### Setup local Dev-Environment

Do this once
* Create your securella folder
* Clone this gitlab project
* clone the securella-web gitlab project
* Enter securella-api project
* run `docker-compose build`

#### Database creation

* run `docker-compose run securella-api bundle exec rake db:create`
* run `docker-compose run securella-api bundle exec rake db:seed`

## Deployment instructions

We use Heroku as hosting service.

#### One-time configuration

Add the heroku origin, in order to deploy the app.

Add the following to your '.git/config' file:

---
[remote "staging"]
	url = https://git.heroku.com/securella-api-staging.git
	fetch = +refs/heads/*:refs/remotes/heroku/*
[remote "heroku"]
  url = https://git.heroku.com/securella-api.git
  fetch = +refs/heads/*:refs/remotes/heroku/*
---


#### Get access to the heroku dashboard

You need a Heroku account. Register here:

https://dashboard.heroku.com/account

Ask one of the existing users to be added to the Securella pipeline.
Current users are
* Nils Löwe
* Friederike Löwe
* Mohamad Badrah


#### Deploy the app

##### Deploying to staging

Deploy the master branch to the staging environment

* run `git push staging master`

Deploy a feature branch to the staging environment

* run `git push staging feature/SEC-xx:master`

Test the deployed app here:

https://staging.securella.com


##### Deploying to staging

Deploy a feature branch to production

* run `git push heroku feature/SEC-xx:master`

Deploy the master branch to production

* run `git push heroku master`

Test the deployed app here:

https://app.securella.com
