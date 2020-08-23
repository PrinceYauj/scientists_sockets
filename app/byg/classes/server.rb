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
        response = handle_data(data)
        client.send(response, 0)
        client.close
      end

      def run
        loop do
          Thread.start(listener.accept) do |client|
            start(client)
          end
        end
      end

      private

      def handle_data(data)
        request = Request.new(data).parse
        response = Controller.new.call(request)
        Response.new(response).generate
      end
    end
  end
end
