module Byg
  module Classes
    class App
      BUFF_SIZE = 4096

      def self.run
        server = TCPServer.new('127.0.0.1', 3000)
        client = server.accept
        env = Request.new(client.recv(BUFF_SIZE)).parse
        p env
        controller = Controller.new
        p controller.call(env)
        server.close
        client.close
      end
    end
  end
end