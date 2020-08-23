module Byg
  module Classes
    class Request

      def initialize(str)
        @head, @body = str.split("\r\n\r\n")
        @start_line, *@headers = @head.split("\r\n")
        @verb, @path = @start_line.split(' ')
      end

      def parse
        result = {}
        result["REQUEST_METHOD"] = verb
        result["PATH_INFO"] = path
        result["BODY"] = body
        result["HEADERS"] = headers
        result
      end

      private

      attr_reader :verb, :path, :body

      def headers
        res = {}
        @headers.each do |s| 
          k, v = s.split(": ", 2)
          res[k] = v
        end
        res
      end
    end
  end
end
