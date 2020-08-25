module Byg
  module Classes
    class Controller

      BAD_REQUEST = [400, ["bad request"]]

      def call(env)
        response = handle_route(env)
        return BAD_REQUEST unless response

        [200, response]
      rescue StandardError => e
        [400, e]
      end

      private

      def handle_route(env)
        r = Router.new(env[:verb], env[:path])
        return unless r.valid?

        action = r.action
        route_id = r.id
        p = params(env[:body], route_id)
        action.call(p)
      end

      def params(body,route_id)
        res = json_parse(body) || {}
        res[:route_id] = route_id if route_id
        res
      end

      def json_parse(string)
        JSON.parse(string) rescue nil
      end
    end
  end
end
