module Micetrap
  module Services
    class Openvpn < Base

      protected

      def default_ports
        [443, 1194]
      end

      def response
        @response ||=
          [
            ">INFO:OpenVPN Management Interface Version 1.9 -- type 'help' for more info\r\n>",
          ].sample
      end

    end
  end
end