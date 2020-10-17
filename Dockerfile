FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client build-essential zlib1g-dev liblzma-dev npm
RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  postgresql-client \
  zlib1g-dev \
  liblzma-dev \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY package.json .
COPY yarn.lock .

RUN bundle install
RUN yarn install --check-files

COPY . /myapp

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
