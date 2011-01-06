module Micetrap
  module Services
    class Torrent < Base

      protected

      def default_ports
        []
      end

      def response
        @response ||=
          [
            "\x13BitTorrent protocol\0\0\0\0\0\0\0\0",
          ].sample
      end

    end
  end
end
