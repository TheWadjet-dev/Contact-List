# World Clock - Ruby Sinatra Application

This is a simple world clock application built with Ruby and Sinatra. The app displays the current time in various cities around the world. It uses the `tzinfo` gem to get the time in different time zones and serves the data through a web interface.

## Features
- Displays the current time for a selection of cities.
- Built using the **Sinatra** web framework.
- Time zones are handled with the **tzinfo** gem.

## Technologies Used
- **Ruby**: Programming language used for building the application.
- **Sinatra**: A lightweight web framework for Ruby.
- **TZInfo**: Gem used to handle time zone information and get the current time in different cities.
- **Docker**: To containerize the application for easy deployment.

## Installation

### Prerequisites

Ensure you have the following installed:

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (version 3.1.0 or higher)
- [Bundler](https://bundler.io/)
- [Docker](https://www.docker.com/get-started) (for running the app in a container)

### Step-by-Step Setup

1. **Clone the repository**:

   ```bash
   git clone https://github.com/TheWadjet-dev/world_clock_app.git
   cd world_clock_app
