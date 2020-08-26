# frozen_string_literal: true

module Byg
  module Classes
    # Simple http-server. Uses socket connections and transmission of data
    # Receives and handles requests, returns requested data (or 'bad request')
    class Server
      BUFF_SIZE = 4096

      attr_reader :listener

      def initialize(host, port)
        @listener = TCPServer.new(host, port)
      end

      def start(serv_sock)
        request = serv_sock.recv(BUFF_SIZE)
        response = handle_data(request)
        serv_sock.send(response, 0)
        serv_sock.close
      end

      def run
        loop do
          Thread.start(listener.accept) do |serv_sock|
            start(serv_sock)
          end
        end
      end

      private

      def handle_data(request)
        env = Request.new(request).parse
        response = Controller.new.call(env)
        Response.new(response).generate
      end
    end
  end
end
