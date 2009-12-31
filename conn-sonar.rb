require 'rubygems'
require 'net/ping/icmp'

host = 'www.google.com'

i = Net::Ping::ICMP.new(host)
result = nil
ping_thread = Thread.new { result = i.ping? }
sound_thread = Thread.new {`playsound sounds/ping.wav >> /dev/null` }
ping_thread.join
p i.duration
sound_thread.join
t = Thread.new {`playsound sounds/pong.wav >> /dev/null` } if result == true 
t.join
