require 'sinatra'
require 'savon'
require 'net/http'
require 'json'
require 'uri'

set :port, 4567

get '/clisoap2' do
  n = params['n']

  # 1. Consumir el servicio SOAP original
  client = Savon.client(
    wsdl: "https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL",
    open_timeout: 30,
    read_timeout: 30
  )
  response = client.call(:number_to_words, message: { "ubiNum" => n })
  texto_ingles = response.body[:number_to_words_response][:number_to_words_result].strip

  # 2. Traducir el resultado mediante la API pública de MyMemory
  texto_codificado = URI.encode_www_form_component(texto_ingles)
  url = URI("https://api.mymemory.translated.net/get?q=#{texto_codificado}&langpair=en|es")

  respuesta_api = Net::HTTP.get(url)
  datos_json = JSON.parse(respuesta_api)
  texto_espanol = datos_json['responseData']['translatedText']

  # 3. Retornar el texto traducido en minúsculas
  texto_espanol.downcase
end
