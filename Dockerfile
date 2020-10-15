FROM ruby:2.6.6-alpine
ENV BUNDLER_VERSION=2.1.4 LANG=en_US.UTF-8
RUN apk add --update --no-cache \
  binutils-gold \
  build-base \
  curl \
  file \
  g++ \
  gcc \
  git \
  less \
  libstdc++ \
  libffi-dev \
  libc-dev \
  linux-headers \
  libxml2-dev \
  libxslt-dev \
  libgcrypt-dev \
  make \
  netcat-openbsd \
  nodejs \
  openssl \
  pkgconfig \
  postgresql-dev \
  postgresql-client \
  python3 \
  tzdata
RUN gem install bundler -v 2.1.4
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install
RUN bundle exec rails db:create db:migrate db:seed
COPY . ./
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
