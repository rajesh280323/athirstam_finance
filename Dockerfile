# Use the official Ruby image
FROM ruby:3.2.2

# Set Rails environment to production
ENV RAILS_ENV production

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
      # Add any additional packages needed here
      && \
    gem install rails bundler

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets (if needed)
# RUN bundle exec rails assets:precompile

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
