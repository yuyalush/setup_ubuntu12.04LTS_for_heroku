#!/bin/bash
# Setup for git , Ruby1.9.2 , Rails3.2.8

echo 'git'
sudo apt-get -y install git

echo 'libs'
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev libsqlite3-dev g++ ruby1.9.1-dev

echo 'rbenv'
sudo apt-get -y install rbenv
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

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
echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc

gem install rails -v=3.2.8
gem install foreman
rbenv rehash
rails new testapp --skip-bundle
cd testapp
echo "gem 'thin'" >> Gemfile
gem 'therubyracer' >> Gemfile
echo "web: bundle exec rails server thin -p 3000 -e development" >> Procfile
bundle install

rails g scaffold Book title:string price:integer
rake db:migrate
foreman start


