require 'socket'               # Get sockets from stdlib
require 'rubyserial'

#params for serial port 
serial_port = 'COM1'
baud_rate = 2400
data_bits = 8

server = TCPServer.new('0.0.0.0', 20000)  # Socket to listen on port 2000
loop {                        			  # Servers run forever
  Thread.start(server.accept) do |client| # Wait for a client to connect

    sp = Serial.new(serial_port, baud_rate, data_bits)
 
    #read serial port forever
    while true do
      while (i = sp.gets.chomp) do
        client.puts i[0..8].tr("^0-9.-", '')
      end
    end
 
    sp.close
    client.close                 # Disconnect from the client
  end
}

