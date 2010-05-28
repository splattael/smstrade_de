# Copyright (c) 2010 Maikel Urlitzki <maikel@urlitzki.de>
#
# Thanks to http://github.com/splattael
#
# http://github.com/maikelcoke/smstrade_de
#
# For use with http://www.smstrade.de

# = Configuration
#
#   # config/intializers/smstrade.rb
#   Smstrade.key = "YOUR_KEY"
#   Smstrade.route = "ROUTE"
class Smstrade

  require "net/http"

  # API-Key
  cattr_accessor :key
  self.key ||= ""

  # Gateway-URL
  cattr_accessor :gateway
  self.gateway ||= "gateway.smstrade.de"

  # SMS-Route (basic, economy, gold, direct)
  cattr_accessor :route
  self.route ||= "basic"

  # Source identifier
  cattr_accessor :from
  self.from ||= "smstrade_de"

  # Testmode, default off
  cattr_accessor :debug
  self.debug ||= 0  

  # Encoding
  cattr_accessor :charset
  self.charset ||= "UTF-8"

  # Example:
  #
  #   # Controller
  #   Smstrade.new do |sms|
  #     @result, @response = sms.send(:number => "+491601234567", :text => "This is a dummy text.")
  #   end
  def initialize(&block)
    yield(self) if block_given?  
  end

  # Required +options+ are:
  # <tt>:number</tt>::            Mobile number e.g. +49160123456
  # <tt>:text</tt>::              SMS-Text e.g. "Hello mate, all right?"
  #
  # Optional +options+ are:
  # <tt>:debug</tt>::             Debug mode
  #                               0 = send the message
  #                               1 = sms will not send and not charged                                                
  def send(options={})
    string = prepare_string(options)
    begin
      response = Net::HTTP::get(gateway, "#{string}")
    rescue
      response = 0
    end
    return response.to_i == 100, response(response.to_i)
  end

  private

  def prepare_string(options)
    message = encode_message(options[:text])
    str = "/?key=#{key}&to=#{options[:number]}&message=#{message}&route=#{route}&from=#{from}&charset=#{charset}&debug=#{debug}"
    warn str
    return str
  end

  def encode_message(message)
    CGI::escape(message)
  end  

  def response(code)
    res = Array.new
    res[0] = "No connection to the gateway"
    res[10] = "Recipient invalid"
    res[20] = "Source  identifier too long"
    res[30] = "Message text too long"
    res[31] = "Message type not correct"
    res[40] = "Wrong SMS type"
    res[50] = "Login error"
    res[60] = "No funds"
    res[70] = "Network not supported for this route"
    res[71] = "Feature not possible for this route"
    res[80] = "Can't send the SMS"
    res[90] = "Transmission not possible"
    res[100] = "The SMS was sent successful"
    return res[code.to_i]
  end

end