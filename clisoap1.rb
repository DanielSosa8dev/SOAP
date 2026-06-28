require 'sinatra'
require 'humanize'

# Configurar el puerto del servidor web
set :port, 4567

get '/clisoap1' do
  # Convertir el parámetro recibido en la URL a un número entero
  numero = params['n'].to_i
  
  # Forzar la configuración local a inglés para obtener el texto base
  Humanize.config.default_locale = :en
  
  # Retornar el resultado en inglés
  numero.humanize
end
