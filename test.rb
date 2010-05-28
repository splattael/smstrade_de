require "active_support"
require "lib/smstrade"

Smstrade.key = "YOUR_KEY"
Smstrade.route = "economy"

Smstrade.new do |sms|
  @result, @response = sms.send(:number => "", :text => "This is a test SMS.", :debug => 1)
end

p("Result '#{@result}' with response '#{@response}'")