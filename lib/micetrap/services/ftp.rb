module Micetrap
  module Services
    class Ftp < Base

      protected

      def default_ports
        [21]
      end

      def response
        @response ||=
          [
            "220-FTP server (lukemftpd 1.1) ready.\r\n",
            "220 Welcome to Pure-FTPd 1.8\r\n",
            "220--------------------------------------------------------------------------------\r\n220-This is the \"Banner\" message for the Mac OS X Server's FTP server process.\r\n",
          ].sample
      end

    end
  end
end
