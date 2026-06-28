require 'sinatra'
require 'humanize'

# Configurar el idioma global de la gema a español
Humanize.config.default_locale = :es

set :port, 4567

get '/connativo' do
  # Convertir el parámetro recibido en la URL a un número entero
  numero = params['n'].to_i

  # Ejecutar la conversión nativa
  numero.humanize
end
