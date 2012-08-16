#!/bin/bash
# Setup for git , Ruby1.9.2 , Rails3.2.8

echo 'Install libs'
sudo apt-get -y install git build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev libsqlite3-dev g++ 

echo 'Install rbenv'
sudo apt-get -y install rbenv
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
eval "$(rbenv init -)"
source ~/.bashrc

echo 'Install ruby-build'
git clone git://github.com/sstephenson/ruby-build.git
cd ruby-build
sudo ./install.sh
cd ..

echo 'Install Ruby1.9.2-p320'
rbenv install 1.9.2-p320
rbenv rehash
rbenv global 1.9.2-p320
echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc

echo 'Install Rails & Generate testapp'
gem install rails -v=3.2.8
gem install foreman
rbenv rehash

rails new testapp --skip-bundle
cd testapp
echo "gem 'thin'" >> Gemfile
echo "gem 'therubyracer'" >> Gemfile
echo "web: bundle exec rails server thin -p 3000 -e development" >> Procfile
bundle install

rails g scaffold Book title:string price:integer
rake db:migrate
foreman start


