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
      @file ||= File.new(@filename, 'a')
    end

    def log_probe(line, remote_host, remote_port)
      content = line.strip.length > 0 ? line
                                      : '(empty line)'
      logged = "\n#{Time.now} Recorded a probe coming from #{remote_host}:#{remote_port} containing the following: #{content}"
      File.open(@filename, 'a') do |f|
        f.write logged
      end
      puts logged
    end

    def log_message(line)
      logged = "\n#{Time.now} ::: #{line} :::"
      File.open(@filename, 'a') do |f|
        f.write logged
      end
      puts logged
    end

  end
end
