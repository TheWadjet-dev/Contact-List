# app.rb
require 'sinatra'
require 'tzinfo'

# List of cities and their time zones
TIME_ZONES = {
  'New York' => 'America/New_York',
  'London' => 'Europe/London',
  'Tokyo' => 'Asia/Tokyo',
  'Sydney' => 'Australia/Sydney',
  'Paris' => 'Europe/Paris',
  'Berlin' => 'Europe/Berlin',
  'Moscow' => 'Europe/Moscow',
  'Dubai' => 'Asia/Dubai'
}

# Route to display the world clock
get '/' do
  @times = {}

  # Get the current time for each city
  TIME_ZONES.each do |city, zone|
    tz = TZInfo::Timezone.get(zone)
    @times[city] = tz.now.strftime('%Y-%m-%d %H:%M:%S')
  end

  erb :index
end
