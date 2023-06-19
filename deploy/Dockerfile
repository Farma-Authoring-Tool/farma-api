# Base Image
FROM ruby:3.2.2

# Encoding
# C.UTF8 locale supports Computer English language
ENV LANG C.UTF-8
ENV RAILS_ENV=production

RUN apt-get update -qq && \
  apt-get install -y curl \
  build-essential \
  libpq-dev    \
  libxml2-dev  \
  libxslt1-dev \
  imagemagick  \
  cron         \
  vim

# Set working directory
WORKDIR /app

# copy Gemfile and Gemfile.lock and install gems before copying rest of the application
# so the steps will be cached until there won't be any changes in Gemfile
COPY Gemfile* ./
RUN bundle install

COPY . .

ENTRYPOINT [ "./config/docker-entrypoint.sh" ]

CMD bundle exec rails s -p 3000 -b '0.0.0.0'
