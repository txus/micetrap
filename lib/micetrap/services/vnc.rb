module Micetrap
  module Services
    class Vnc < Base

      protected

      def default_ports
        [5800, 5900]
      end

      def response
        @response ||=
          [
            "RFB 003.009\n",
          ].sample
      end

    end
  end
end
