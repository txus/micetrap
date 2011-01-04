require 'spec_helper'

module Micetrap
  module Services
    describe Base do
      describe "#fire" do
        context 'when given a port' do
          it 'fires up the service on that port' do
            
          end
        end
        context 'when port is nil' do
          it 'fires up the service on one of the default ports' do
            
          end
          context 'but when no default ports are specified' do
            it 'uses the port 0' do
              
            end
          end
        end
        it 'logs a message telling the trap is listening' do

        end
        it 'calls read_from every time a connection is accepted' do
          connection = double('connection')
          server = double('server', :addr => [1,2,3], :accept => connection)
          TCPServer.should_receive(:open).and_return server
          subject.logger.stub(:log)

          subject.should_receive(:read_from).with(connection).any_number_of_times
          puts "Press Ctrl-C to resume specs! Don't worry, it's all under control :)"
          subject.fire
        end
      end   
    end
  end
end
