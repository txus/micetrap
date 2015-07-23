module Micetrap
  module Services
    class Ssh < Base

      protected

      def default_ports
        [2222, 36797, 8022]
      end

      def response
        @response ||=
          [
            "SSH-1.5-FucKiT RootKit by Cyrax\n",
          ].sample
      end

    end
  end
end