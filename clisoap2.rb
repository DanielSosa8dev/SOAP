require 'sinatra'
require 'humanize'

set :port, 4567

# Diccionario interno para la traducción de componentes numéricos esenciales
DICCIONARIO_TRADUCCION = {
  "one" => "un", "hundred" => "cien", "thousand" => "mil", "eighty" => "ochenta",
  "ten" => "diez", "twenty" => "veinte", "thirty" => "treinta", "forty" => "cuarenta"
}

get '/clisoap2' do
  numero = params['n'].to_i
  
  # 1. Obtener el texto base en inglés
  Humanize.config.default_locale = :en
  texto_ingles = numero.humanize.downcase
  
  # 2. Procesar la traducción palabra por palabra de forma local
  palabras_ingles = texto_ingles.split(/[\s-]+/)
  palabras_espanol = palabras_ingles.map { |palabra| DICCIONARIO_TRADUCCION[palabra] || palabra }
  
  # 3. Retornar el resultado traducido
  palabras_espanol.join(" ")
end
