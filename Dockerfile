FROM ruby:2.5

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN gem install bundler
RUN bundle install --without development test

ADD . $APP_HOME

EXPOSE 4567

ENV RACK_ENV "production"

CMD ["bundle", "exec", "rackup"]
