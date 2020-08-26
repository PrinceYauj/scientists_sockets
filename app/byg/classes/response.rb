# frozen_string_literal: true

module Byg
  module Classes
    # Support class to generate http-response from requested data
    class Response
      def initialize(array)
        @status = array[0]
        @body = array[1].to_json
      end

      def generate
        status_text = { '200' => 'OK', '400' => 'bad request' }
        [
          "HTTP/1.1 #{status} #{status_text[status.to_s]}\r\n",
          "Content-Type: text/plain\r\n",
          "Content-Length: #{body.length}\r\n",
          "\r\n",
          body
        ].join
      end

      private

      attr_reader :status, :body
    end
  end
end
