# frozen_string_literal: true

module Byg
  module Classes
    # Calls business logic's method to request data from DB
    # Returns a pair - http response status and requested data (or bad request)
    class Controller
      BAD_REQUEST = [400, ['bad request']].freeze

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

      def params(body, route_id)
        res = json_parse(body) || {}
        res[:route_id] = route_id if route_id
        res
      end

      def json_parse(string)
        JSON.parse(string, symbolize_names: true)
      rescue StandardError
        nil
      end
    end
  end
end
