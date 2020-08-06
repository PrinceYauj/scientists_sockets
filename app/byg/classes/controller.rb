module Byg
  module Classes
    class Controller
      BAD_REQUEST = [400, {}, ["bad request"]]

      def call(env)
        r = Router.new(env["REQUEST_METHOD"], env["PATH_INFO"])
        return BAD_REQUEST unless r.valid?

        action = r.action
        id = r.id
        p = params(env['BODY'], id)
        response = action.call(p)
        [200, {}, [response]]
#        [200, {}, [p.to_s, ' ', action.to_s]]
      end

      private

      def json_parse(string)
        JSON.parse(string) rescue nil
      end

      def params(body, id)
        res = json_parse(body) || {}
        res["id"] = id if id
        res
      end
    end
  end
end
