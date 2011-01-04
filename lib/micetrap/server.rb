require 'socket'

module Micetrap
  class Server
    attr_reader :service
    attr_reader :port
    attr_reader :logger

    def initialize(options)
      raise StandardError.new("Service cannot be empty!") unless options[:service]
      @service = 
        eval("Micetrap::Services::#{options[:service].to_s.capitalize}").new
      @logger = Logger.new
      @port = options[:port] # Optional
    rescue NameError
      raise Services::UnrecognizedServiceException.new("Service #{options[:service].to_s.capitalize} is not recognized")
    end

    def fire!
      @service.fire port
    end

    def log(*args)
      @logger.log(*args) 
    end
         
  end
end
