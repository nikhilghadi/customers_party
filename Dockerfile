FROM ruby:3.3.7

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs sqlite3

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
