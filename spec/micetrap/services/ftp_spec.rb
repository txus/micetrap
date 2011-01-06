require 'spec_helper'

module Micetrap
  module Services
    describe Ftp do

      describe "#default_ports" do
        it 'returns the default ports' do
          Ftp.new.send(:default_ports).should include(21)
        end
      end
      describe "#response" do
        it 'returns a response' do
          Ftp.new.send(:response).should be_a(String)
        end
        it 'caches the response for cohesion' do
          service = Ftp.new
          response = service.send(:response)
          service.instance_variable_get(:@response).should == response
        end
      end
    end
  end
end
