require "lib/smstrade"

Smstrade.key = ""
Smstrade.route = "economy"

Smstrade.new do |sms|
  sms.send(:number => "", :text => "This is a test SMS.")
end