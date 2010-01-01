require 'lib/conn_sonar.rb'

describe ConnSonar do
  context "when pinging" do
    before(:each) do
      @mock_icmp = mock('icmp')
      @mock_icmp.stub!(:duration).and_return(0.0150)
      Net::Ping::ICMP.stub!(:new).and_return(@mock_icmp)
      SDL::Mixer.stub!(:playChannel)
    end

    it "should sound a ping when a ping is sent" do
      @mock_icmp.stub!(:ping?).and_return(true)
      SoundPlayer.should_receive(:ping)

      c = ConnSonar.new('google.com')
      c.ping
    end

    it "should sound a pong when a return is received" do
      @mock_icmp.stub!(:ping?).and_return(true)
      SoundPlayer.should_receive(:pong)

      c = ConnSonar.new('google.com')
      c.ping
    end

    it "should not sound any return when no pong is received" do
      @mock_icmp.stub!(:ping?).and_return(false)
      SoundPlayer.should_not_receive(:pong)

      c = ConnSonar.new('asdfjdfgh.com')
      c.ping
    end
  end

  context "when ticking" do
    before(:each) do
      @mock_icmp = mock('icmp')
      @mock_icmp.stub!(:ping?).and_return(true)
      Net::Ping::ICMP.stub!(:new).and_return(@mock_icmp)
      SDL::Mixer.stub!(:playChannel)
    end

    it 'should play 1 tick if pong takes less than 100ms' do
      @mock_icmp.stub!(:duration).and_return(0.050)
      SoundPlayer.should_receive(:ticks).with(1)

      c = ConnSonar.new('google.com')
      c.ping
    end

    it 'should play 2 ticks if pong takes between 100-200ms' do
      @mock_icmp.stub!(:ping?).and_return(true)
      @mock_icmp.stub!(:duration).and_return(0.150)
      SoundPlayer.should_receive(:ticks).with(2)

      c = ConnSonar.new('farawayplace.com')
      c.ping
    end
  end


end
