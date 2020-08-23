module Byg
  module Classes
    class Controller

      BAD_REQUEST = [400, ["bad request"]]

      def call(request)
        response = handle_route(request)
        return BAD_REQUEST unless response

        [200, response]
      rescue Sequel::Error => e
        [400, e]
      end

      private

      def handle_route(request)
        r = Router.new(request["REQUEST_METHOD"], request["PATH_INFO"])
        return unless r.valid?

        action = r.action
        id = r.id
        p = params(request['BODY'], id)
        action.call(p)
      end

      def params(body, id)
        res = json_parse(body) || {}
        res['route_id'] = id if id
        res
      end

      def json_parse(string)
        JSON.parse(string) rescue nil
      end
    end
  end
end
