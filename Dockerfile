
FROM ruby:alpine
ADD ./ /opt/mars-rover
WORKDIR /opt/mars-rover
RUN adduser -D ci && \
    chown -R ci:ci /opt/mars-rover
USER ci
RUN bundle install

