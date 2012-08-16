#!/bin/bash
# Setup for git , Ruby1.9.2 , Rails3.2.8

echo 'git'
sudo apt-get -y install git

echo 'libs'
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev libsqlite3-dev g++ ruby1.9.1-dev

echo 'rbenv'
sudo apt-get -y install rbenv
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# eval "$(rbenv init -)"
source ~/.bashrc
# echo 'eval "$(rbenv init -)"' >> ~/.zshrc

echo 'ruby-build'
git clone git://github.com/sstephenson/ruby-build.git
cd ruby-build
sudo ./install.sh
cd ..

# install Ruby 1.9.2-p320
echo 'install Ruby1.9.2-p320'
rbenv install 1.9.2-p320
rbenv rehash
rbenv global 1.9.2-p320

echo 'check'
ruby -v

echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc
sudo gem install rails -v=3.2.8
sudo gem install foreman
rbenv rehash

# sample app
rails new testapp --skip-bundle
cd testapp
echo "gem 'thin'" >> Gemfile
echo "web: bundle exec rails server thin -p 3000 -e development" >> Procfile
sudo bundle install

rails g scaffold Book title:string price:integer
rake db:migrate
foreman start



