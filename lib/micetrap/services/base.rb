module Micetrap
  module Services
    class Base

      class ClientQuitError < RuntimeError; end

      attr_reader :logger

      def initialize
        @logger = Logger.new self.name.downcase.to_sym
      end

      def fire port = nil
        port = port.to_i if port
        begin
          server = TCPServer.open(port || default_ports.sample || 0)
        rescue Errno::EACCES
          puts "Looks like you are trying to use a system port, for which you need root privileges.\nRun micetrap with another port if you don't want to sudo!\n"
          exit(1)
        end
        @port = server.addr[1]
        @addrs = server.addr[2..-1].uniq

        logger.log_message "#{name} trap listening on #{@addrs.collect{|a|"#{a}:#{port}"}.join(' ')}"
        listen(server)
      end

      def listen(server)
        # Handle Ctrl-C to exit!
        interrupted = false
        trap("INT") { puts "Gracefully exiting..."; exit(0) }

        while not interrupted do
          socket = server.accept
          Thread.start do
            read_from(socket)
          end
        end
      end

      def read_from(socket)
        s = socket

        port = s.peeraddr[1]
        name = s.peeraddr[2]
        addr = s.peeraddr[3]

        begin
          while line = s.gets # read a line at a time
            raise ClientQuitError if line =~ /^die\r?$/

            logger.log_probe line, name, port

            if line.strip == ""
              s.write response
              logger.log_message "Responded misleadingly: let's drive those hackers nuts!"
              s.close
              Kernel.exit(0)
            end
          end
        rescue ClientQuitError
          logger.log_message "#{name}:#{port} disconnected"
        ensure
          s.close # close socket on error
        end
      end

      protected

      def default_ports; []; end;
      def response; ""; end;

      def name
        self.class.name.split('::').last
      end

    end
  end
end
