#!/bin/bash -i

# install ruby dependencies
sudo apt update
sudo apt install git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev ffmpeg cucumber libpq-dev pkg-config npm

# installs rbevn
curl -fsSL 'https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer' | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

# install chromedriver for cucumber testing
wget 'https://chromedriver.storage.googleapis.com/106.0.5249.61/chromedriver_linux64.zip'
sudo unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver

# install google chrome for cucumber testing
wget 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo apt install ./google-chrome-stable_current_amd64.deb

# install ruby
LATEST_RUBY_VERSION=$(rbenv install --list | grep -E '^[0-9]+\.[0-9]+\.[0-9]+' | tail -1)
rbenv install $LATEST_RUBY_VERSION -v
rbenv global $LATEST_RUBY_VERSION
rbenv local $LATEST_RUBY_VERSION
ruby -v

# add extra gems
gem install selenium-webdriver -v 3.142.7
gem install rails 

# update and install all gems
bundle update
bundle install

# add npm 
sudo npm install --global n
sudo n latest

# add yarn
sudo npm install --global yarn
yarn upgrade
yarn install

# get newly installed commands
source ~/.bashrc

# migrate models and see dbs
rake db:migrate
rake db:seed

# testing 
rake cucumber
rspec
