require 'rubygems'
require 'net/ping/icmp'
require 'lib/sound_player.rb'

class ConnSonar
  def initialize(host)
    @host = host
  end

  def ping
    i = Net::Ping::ICMP.new(@host)
    SoundPlayer.ping
    result = i.ping?
    SoundPlayer.pong if result
    milliseconds = Integer(i.duration * 1000)
    SoundPlayer.ticks(milliseconds / 100)
  end
end
