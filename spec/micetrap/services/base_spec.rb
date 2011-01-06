require 'spec_helper'

module Micetrap
  module Services
    describe Base do
      describe "#fire" do

        before(:each) do
          subject.stub(:listen)
        end

        context 'when given a port' do
          it 'fires up the service on that port' do
            server = double('server', :addr => [1,2,3])
            TCPServer.should_receive(:open).with(5900).and_return server
            subject.fire 5900
          end
        end
        context 'when port is nil' do
          it 'fires up the service on one of the default ports' do
            server = double('server', :addr => [1,2,3])
            subject.stub_chain('default_ports.sample') { 445 }
            TCPServer.should_receive(:open).with(445).and_return server

            subject.fire
          end
          context 'but when no default ports are specified' do
            it 'uses the port 0' do
              server = double('server', :addr => [1,2,3])
              subject.stub(:default_ports) { [] }
              TCPServer.should_receive(:open).with(0).and_return server

              subject.fire
            end
          end
        end
        it 'logs a message telling the trap is listening' do
          server = double('server', :addr => [1,2,3])
          TCPServer.stub(:open).and_return server
          subject.logger.should_receive(:log_message).with do |arg|
            arg.should include('Base trap listening') 
          end
          subject.fire
        end
      end
      describe "#listen", :blocking => true do
        it 'calls read_from every time a connection is accepted' do
          Kernel.stub(:exit)
          connection = double('connection')
          server = double('server', :addr => [1,2,3], :accept => connection)

          subject.should_receive(:read_from).with(connection).any_number_of_times
          puts "Press Ctrl-C to resume specs! Don't worry, it's all under control :)"
          subject.listen(server)
        end
      end   
      describe "#read_from" do
        let(:peeraddr) { [ nil, 4983, 'hackerz.com', '293.13.23.32'] }
        let(:socket) do
          double :socket, :peeraddr => peeraddr
        end
        before(:each) do
          socket.should_receive(:close).any_number_of_times
        end

        context 'when the socket contains a line with die' do
          it 'dies' do
            socket.should_receive(:gets).and_return 'die'
            subject.logger.should_not_receive(:log_probe)
            subject.logger.should_receive(:log_message).with("hackerz.com:4983 disconnected")

            subject.read_from(socket)
          end
        end

        context 'otherwise' do
          it 'logs the probe' do
            socket.should_receive(:gets).and_return 'some probe', nil
            subject.logger.should_receive(:log_probe).with 'some probe', 'hackerz.com', 4983

            subject.read_from(socket)
          end
          context 'when the line is blank' do
            it 'does respond with the appropriate response' do
              Kernel.stub(:exit)
              socket.should_receive(:gets).and_return '', nil
              subject.logger.stub(:log_probe)
              appropriate_response = double :response
              subject.should_receive(:response).and_return appropriate_response

              socket.should_receive(:write).with(appropriate_response)
              subject.logger.should_receive(:log_message)

              subject.read_from(socket)
            end
          end
          context 'when the line contains any other thing' do
            it 'does not respond' do
              socket.should_receive(:gets).and_return 'some evil probe', nil
              subject.logger.stub(:log_probe)

              subject.should_not_receive(:response)
              socket.should_not_receive(:write)

              subject.read_from(socket)
            end
          end
        end

      end   
    end
  end
end
