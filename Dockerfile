# Use the official Ruby image
FROM ruby:3.0.0

# Set Rails environment to production
ENV RAILS_ENV production

# Install dependencies
RUN apt-get update && \
    apt-get install -y nodejs npm yarn && \
    npm install -g n && n stable && \
    gem install rails bundler

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
