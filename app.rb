require 'sinatra'
require 'tzinfo'

# Definir las zonas horarias
ZONES = [
  'America/New_York',  # Nueva York (EE.UU.)
  'Europe/London',     # Londres (Reino Unido)
  'Asia/Tokyo',        # Tokio (Japón)
  'Australia/Sydney',  # Sídney (Australia)
  'Africa/Johannesburg', # Johannesburgo (Sudáfrica)
  'Europe/Paris'       # París (Francia)
]

# Página principal que carga el reloj mundial
get '/' do
  erb :index
end

# API para obtener la hora actual en una zona horaria específica
get '/time/:zone' do
  timezone = TZInfo::Timezone.get(params[:zone])
  current_time = timezone.now.strftime("%Y-%m-%d %H:%M:%S")
  current_time.to_json
end
