module Micetrap
  module Services
    class Mysql < Base

      protected

      def default_ports
        [3306]
      end

      def response
        @response ||=
          [
            ".\0\0\0\n4.0.13\0...\0",
          ].sample
      end

    end
  end
end
