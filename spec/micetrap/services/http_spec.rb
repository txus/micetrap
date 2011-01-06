require 'spec_helper'

module Micetrap
  module Services
    describe Http do

      describe "#default_ports" do
        it 'returns the default ports' do
          Http.new.send(:default_ports).should =~ [80, 8080]
        end
      end
      describe "#response" do
        it 'returns a response' do
          Http.new.send(:response).should be_a(String)
        end
        it 'caches the response for cohesion' do
          service = Http.new
          response = service.send(:response)
          service.instance_variable_get(:@response).should == response
        end
      end
    end
  end
end
