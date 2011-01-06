require 'micetrap/services/exceptions'
require 'micetrap/services/base'

require 'micetrap/logger'
require 'micetrap/server'

module Micetrap
  class << self
    def services
      [:ftp, :torrent, :samba, :http, :mysql]
    end
  end
end

Micetrap.services.each do |service|
  require "micetrap/services/#{service}"
end
