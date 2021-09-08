FROM ruby:3.0.0-alpine

WORKDIR /app

COPY Gemfile* ./
COPY app.rb ./
RUN bundle install

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "app.rb"]