# Facebook like posts app example GraphQL API

[![Build Status](https://travis-ci.com/robertziel/facebook_news_feed_example_api.svg?branch=master)](https://travis-ci.com/robertziel/facebook_news_feed_example_api) [![Coverage Status](https://coveralls.io/repos/github/robertziel/facebook_news_feed_example_api/badge.svg?branch=master)](https://coveralls.io/github/robertziel/facebook_news_feed_example_api?branch=master)

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

Run the development server (I used port 8080 for backend and 3000 for client):

```
rails s -p 8080
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

## To do
* Better posts truncate if first paragraph is short
* Move all ActiveCable transmissions to separate jobs
* Integration specs for subscriptions
* In specs there are some warnings to fix
* Reactions subscription would be nice
* Order data by created_at instead of id in AllPosts and AllComments resolvers
