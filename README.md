# Facebook like feeds GraphQL API

[![Build Status](https://travis-ci.com/robertziel/facebook_post_example_api.svg?branch=master)](https://travis-ci.com/robertziel/facebook_post_example_api) [![Coverage Status](https://coveralls.io/repos/github/robertziel/facebook_post_example_api/badge.svg?branch=master)](https://coveralls.io/github/robertziel/facebook_post_example_api?branch=master)

Init based on boilerplate: https://github.com/robertziel/rails_graphql_jwt_devise_auth_boilerplate

Client (ReactJS): https://github.com/robertziel/facebook_post_example_client

Technology:

* Rails
* GraphQL
* Devise JWT
* MySQL

## Quick start

Clone env_sample to .env for local development.

```
cp .env.example .env
```

Install the bundle:
```
bundle install
```

Make sure you have MySQL working.
Default user is set to `root` in `config/database.yml`.
Then you can prepare your database:

```
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

Run the development server:

```
rails s
```

## Before commit
Set up overcommit to make sure your code is clean :) :

```bash
gem install overcommit
bundle install --gemfile=.overgems.rb
overcommit --install
```
Then you can commit your changes! And don't forget to run specs before:

```bash
bundle exec rspec
```
