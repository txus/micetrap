require 'spec_helper'

module Micetrap
  module Services
    describe Samba do

      describe "#default_ports" do
        it 'returns the default ports' do
          Samba.new.send(:default_ports).should =~ [135, 139, 445]
        end
      end
      describe "#response" do
        it 'returns a response' do
          Samba.new.send(:response).should be_a(String)
        end
        it 'caches the response for cohesion' do
          service = Samba.new
          response = service.send(:response)
          service.instance_variable_get(:@response).should == response
        end
      end
    end
  end
end
