require "lib/smstrade"

Smstrade.key = ""
Smstrade.route = "economy"

Smstrade.new do |sms|
  result, response = sms.send(:number => "", :text => "This is a test SMS.")
end

p("Result '#{result}' with response '#{response}'")