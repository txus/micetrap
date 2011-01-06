require 'spec_helper'

module Micetrap
  module Services
    describe Mysql do

      describe "#default_ports" do
        it 'returns the default ports' do
          Mysql.new.send(:default_ports).should include(3306)
        end
      end
      describe "#response" do
        it 'returns a response' do
          Mysql.new.send(:response).should be_a(String)
        end
        it 'caches the response for cohesion' do
          service = Mysql.new
          response = service.send(:response)
          service.instance_variable_get(:@response).should == response
        end
      end
    end
  end
end
