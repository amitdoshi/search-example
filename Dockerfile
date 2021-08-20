# syntax=docker/dockerfile:1
FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /splunk-search-assignment
COPY Gemfile /splunk-search-assignment/Gemfile
COPY Gemfile.lock /splunk-search-assignment/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]