# Use the official Ruby image as a base image
FROM ruby:3.3.4

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies for the Sinatra app (e.g., build tools)
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install the required Ruby gems
RUN bundle install

# Copy the rest of the application files into the container
COPY . /app

# Expose the port Sinatra will use (default is 4567)
EXPOSE 4567

# Start the Sinatra application
CMD ["ruby", "app.rb", "-o", "0.0.0.0"]
