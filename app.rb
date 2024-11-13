# Import necessary libraries
require 'timezone'
require 'tty-prompt'
require 'time'

class WorldClock
  def initialize
    @prompt = TTY::Prompt.new
    @zones = ['America/New_York', 'Europe/London', 'Asia/Tokyo', 'Australia/Sydney', 'America/Los_Angeles', 'Europe/Madrid']
  end

  def show_menu
    puts "\nWelcome to the World Clock!"
    while true
      city = @prompt.select("Select a city to see the time:", @zones)
      show_time(city)
      continue = @prompt.yes?("Would you like to check another city?")
      break unless continue
    end
  end

  def show_time(city)
    zone = Timezone::Zone.new :zone => city
    time = zone.time Time.now
    formatted_time = time.strftime("%H:%M:%S")
    puts "\nThe time in #{city.split('/').last.gsub('_', ' ')} is: #{formatted_time}"
  end
end

# Run the app
WorldClock.new.show_menu
