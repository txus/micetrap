module Micetrap
  module Services
    class Minecraft < Base

      protected

      def default_ports
        [443, 1194]
      end

      def response
        @response ||=
          [
            "\x0eYou need to log in!                                             ",
          ].sample
      end

    end
  end
end