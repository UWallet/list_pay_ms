FROM ruby:2.3
RUN mkdir /list_pay_ms
WORKDIR /list_pay_ms
ADD Gemfile /list_pay_ms/Gemfile
ADD Gemfile.lock /list_pay_ms/Gemfile.lock
RUN bundle install
ADD . /list_pay_ms
