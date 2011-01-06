module Micetrap
  module Services
    class Http < Base

      protected

      def default_ports
        [80, 8080]
      end

      def response
        @response ||=
          [
            "HTTP/1\.0 200 OK\r\nContent-Type: text/html\r\n\r\n<html>\n<body>\n<ul><li>\n<i>com\.apple\.KernelEventAgent</i>\n",
          ].sample
      end

    end
  end
end
