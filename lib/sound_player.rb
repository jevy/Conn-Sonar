require 'sdl'

class SoundPlayer
  SDL::init(SDL::INIT_AUDIO)
  SDL::Mixer.open

  def self.ping
    self.play 'lib/sounds/ping.wav'
  end

  def self.pong
    self.play 'lib/sounds/pong.wav'
  end

  def self.ticks(number_of_ticks)
    number_of_ticks.times do
      self.play 'lib/sounds/tick.wav'
    end
  end

  private

  def self.play(filename)
    wave=SDL::Mixer::Wave.load(filename)
    SDL::Mixer.playChannel(0,wave,0)
    self.wait_for_sound_to_end
  end

  def self.wait_for_sound_to_end
    while SDL::Mixer::play?(0)
      sleep 1
    end
  end
end
