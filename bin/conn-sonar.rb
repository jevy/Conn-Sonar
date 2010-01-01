require 'lib/conn_sonar.rb'

c = ConnSonar.new(ARGV[0])
c.ping
