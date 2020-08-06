module Byg
  class Request

    def initialize(str)
      @head, @body = str.split("\r\n\r\n")
      @start_line, *@headers = @head.split("\r\n")
      @verb, @path = @start_line.split(' ')
    end

    def parse
      env = {}
      env["REQUEST_METHOD"] = verb
      env["PATH_INFO"] = path
      env["BODY"] = body
      env["HEADERS"] = headers
      env
    end

    private

    def headers
      res = {}
      @headers.each do |s| 
        k, v = s.split(": ", 2)
        res[k] = v
      end
      res
    end

    attr_reader :verb, :path, :body
  end
end