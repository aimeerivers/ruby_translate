# RubyTranslate provides a simple wrapper around the Google Translate API for detecting and translating languages
#
# Author:: Aimee Daniells (mailto:aimee@edendevelopment.co.uk)
# License:: MIT License

require 'net/http'
require 'uri'
require 'cgi'
require 'json'

# Uses Google Translate to detect and translate languages.
#
# Google documentation here:
# http://code.google.com/apis/ajaxlanguage/documentation/reference.html#_intro_fonje
module RubyTranslate

  # Translate a string from one language to another.
  # The <tt>from</tt> parameter is optional - 
  # if you don't specify it, detect will be used to guess.
  #
  # Examples:
  #
  #   RubyTranslate.translate("Mein Luftkissenfahrzeug ist voller Aale", "en")
  #   => "My hovercraft is full of eels"
  #
  #   RubyTranslate.translate("Il y a un singe qui vole dans l'arbre.", "en")
  #   => "There is a flying monkey in the tree."
  #
  #   RubyTranslate.translate("They are singing in St Peter's Square", "it")
  #   => "Essi sono il canto, in Piazza San Pietro"
  #
  #   RubyTranslate.translate("Eu queria um outro pedacinho de Apfelstrudel, por favor", "sv", "pt")
  #   => "Jag ville ha en bit av Apfelstrudel, tack"
  #
  # Google Translate is not always perfect! Hopefully you already know that!
  #
  def self.translate(text, to, from=nil)
    from = detect(text) if from.nil?
    json = run('translate', {:langpair => "#{from}|#{to}", :q => text})
    return json['responseData']['translatedText'] if json['responseStatus'] == 200
    raise StandardError, json['responseDetails']
  end
  
  # Detect a language given a string of text.
  #
  # Examples:
  #
  #   RubyTranslate.detect("Mein Luftkissenfahrzeug ist voller Aale")
  #   => "de"
  #
  #   RubyTranslate.detect("Safisha viatu yangu mara moja!")
  #   => "sw"
  #
  def self.detect(text)
    json = run('detect', {:q => text})
    return json['responseData']['language'] if json['responseStatus'] == 200
    raise StandardError, json['responseDetails']
  end
  
  private

  def self.run(service, parameters)
    base = 'http://ajax.googleapis.com/ajax/services/language'
    parameters.merge!({:v => 1.0})
    query = parameters.map{|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join('&')
    response = Net::HTTP.get_response(URI.parse("#{base}/#{service}?#{query}"))
    JSON.parse(response.body)
  end

end
