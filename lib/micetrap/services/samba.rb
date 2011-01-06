module Micetrap
  module Services
    class Samba < Base

      protected

      def default_ports
        [135, 139, 445]
      end

      def response
        @response ||=
          [
            "smbd: error while loading shared libraries: libattr.so.1: cannot open shared object file: No such file or directory\n",
          ].sample
      end

    end
  end
end
