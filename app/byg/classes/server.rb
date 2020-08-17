module Byg
  module Classes
    class Server

      BUFF_SIZE = 4096

      attr_reader :listener

      def initialize(host, port)
        @listener = TCPServer.new(host, port)
      end

      def start(client)
        data = client.recv(BUFF_SIZE)
        handle_data(data)
        # TODO form a response
        client.close
      end

      def run
        loop do
          Thread.start(listener.accept) do |client|
            start(client)
          end
        end
      end

      def handle_data(data)
        env = Request.new(data).parse
        Controller.new.call(env)
      end

    end
  end
end
