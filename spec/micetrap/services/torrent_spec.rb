require 'spec_helper'

module Micetrap
  module Services
    describe Torrent do

      describe "#default_ports" do
        it 'returns the default ports' do
          Torrent.new.send(:default_ports).should == []
        end
      end
      describe "#response" do
        it 'returns a response' do
          Torrent.new.send(:response).should be_a(String)
        end
        it 'caches the response for cohesion' do
          service = Torrent.new
          response = service.send(:response)
          service.instance_variable_get(:@response).should == response
        end
      end
    end
  end
end
