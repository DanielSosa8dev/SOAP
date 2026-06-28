require 'sinatra'
require 'humanize'

# Configurar la librería para usar el idioma español de manera nativa
Humanize.config.default_locale = :es

set :port, 4567

get '/connativo' do
  # Convertir el parámetro de la URL a un número entero
  n = params['n'].to_i
  
  # Generar la conversión a letras localmente
  n.humanize
end
