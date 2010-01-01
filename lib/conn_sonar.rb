require 'rubygems'
require 'net/ping/icmp'

class ConnSonar
  def initialize(host)
    @host = host
  end

  def ping
    i = Net::Ping::ICMP.new(@host)
    result = i.ping?
    SoundPlayer.ping
    SoundPlayer.pong if result
  end
end
