require 'sdl'

class SoundPlayer
  SDL::init(SDL::INIT_AUDIO)
  SDL::Mixer.open

  def self.ping
    wave=SDL::Mixer::Wave.load('lib/sounds/ping.wav')
    SDL::Mixer.playChannel(0,wave,0)
    self.wait_for_sound_to_end
  end

  def self.pong
    wave=SDL::Mixer::Wave.load('lib/sounds/pong.wav')
    SDL::Mixer.playChannel(0,wave,0)
    self.wait_for_sound_to_end
  end

  private

  def self.wait_for_sound_to_end
    while SDL::Mixer::play?(0)
      sleep 1
    end
  end
end
