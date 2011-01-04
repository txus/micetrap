require 'spec_helper'

module Micetrap

  module Services
    class Test
    end
  end

  describe Server do
    describe "#initialize" do
      it 'initializes the service' do
        server = Server.new :service => :test
        server.service.should be_a(Services::Test)
      end
      it 'assigns a custom port if given' do
        server = Server.new :service => :test,
                            :port => 80
        server.port.should be(80)
      end
      it 'assigns  a new logger' do
        server = Server.new :service => :test
        server.logger.should be_a(Logger)
      end

      context 'when given an invalid service' do 
        it 'raises' do 
          expect { 
            Server.new :service => :foo
          }.to raise_error(Services::UnrecognizedServiceException)
        end
      end
      context 'when service is blank' do 
        it 'raises' do 
          expect { 
            Server.new :service => nil
          }.to raise_error(StandardError, "Service cannot be empty!")
        end
      end
    end

    describe "#fire!" do
      it 'fires the service' do
        test_service = double('service')
        Services::Test.should_receive(:new).and_return test_service
        server = Server.new :service => :test
        server.stub(:port).and_return 80
        test_service.should_receive(:fire).with(80)

        server.fire!
      end
    end

    describe "#log" do
      it 'delegates to its logger' do
        test_service = double('service')
        my_args = [1,2,3]
        Services::Test.should_receive(:new).and_return test_service
        server = Server.new :service => :test
        server.logger.should_receive(:log).with(*my_args)

        server.log(*my_args)
      end
    end
  end
end
