module Micetrap
  module Services
    class Base

      class ClientQuitError < RuntimeError; end

      attr_reader :logger

      def initialize
        @logger = Logger.new self.class.name.downcase.to_sym
      end

      def fire port = nil
        server = TCPServer.open(port || default_ports.sample || 0)
        @port = server.addr[1]
        @addrs = server.addr[2..-1].uniq

        logger.log_message "#{@name} micetrap listening on #{@addrs.collect{|a|"#{a}:#{port}"}.join(' ')}"

        # Handle Ctrl-C to exit!
        interrupted = false
        trap("INT") { interrupted = true }

        while not interrupted do
          Thread.start do
            read_from(server.accept)
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

            logger.log_probe line, addr, name, port

            if line.strip == ""
              s.write response
              logger.log_message "Responded misleadingly: let's drive those hackers nuts!"
              s.close
              exit(0)
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

    end
  end
end
