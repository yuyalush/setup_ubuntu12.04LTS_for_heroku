#!/bin/bash
# source ~/.bashrc

gem install rails -v=3.2.8
gem install foreman
rbenv rehash
rails new testapp --skip-bundle
cd testapp
echo "gem 'thin'" >> Gemfile
echo "web: bundle exec rails server thin -p 3000 -e development" >> Procfile
sudo bundle install

rails g scaffold Book title:string price:integer
rake db:migrate
foreman start

