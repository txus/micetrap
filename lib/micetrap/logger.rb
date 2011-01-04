module Micetrap
  class Logger
    TIMESTAMP_FORMAT = "%Y-%m-%d__%H-%M"
   
    attr_reader :filename

    def initialize(service_name)
      @service_name = service_name
      @filename = ['micetrap',
                   service_name,
                   Time.now.strftime(TIMESTAMP_FORMAT)
                  ].join('_') + '.log'
    end

    def file
      @file ||= File.open(@filename, 'w')
    end

    def log_probe(line, addr, remote_host, remote_port)
      file.write "\n#{Time.now} Recorded a probe coming from #{remote_host} - #{addr}:#{remote_port} containing the following:\n\t\t#{line}"
    end

    def log_message(line)
      file.write "\n#{Time.now} ::: #{line} :::"
    end

  end
end
