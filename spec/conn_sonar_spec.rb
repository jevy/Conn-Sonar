require 'lib/conn_sonar.rb'
require 'lib/sound_player.rb'

describe ConnSonar do
  before(:each) do
    @mock_icmp = mock('icmp')
    Net::Ping::ICMP.stub!(:new).and_return(@mock_icmp)
  end

  it "should sound a ping when a ping is sent" do
    @mock_icmp.stub!(:ping?).and_return(true)
    SoundPlayer.should_receive(:ping)

    c = ConnSonar.new('asdfjdfgh.com')
    c.ping
  end

  it "should sound a pong when a return is received" do
    @mock_icmp.stub!(:ping?).and_return(true)
    SoundPlayer.should_receive(:pong)

    c = ConnSonar.new('asdfjdfgh.com')
    c.ping
  end

  it "should not sound any return when no pong is received" do
    @mock_icmp.stub!(:ping?).and_return(false)
    SoundPlayer.should_not_receive(:pong)

    c = ConnSonar.new('asdfjdfgh.com')
    c.ping

  end

end
