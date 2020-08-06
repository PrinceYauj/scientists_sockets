module Byg
  class Router
    VALID_PATH = /\A\/+(scientists|inventions)(\/+\d+\s*)?\z/
    VALID_VERB = /\A\s*(GET|POST|PUT|DELETE)\s*/i
    ROUTE_MAP = {
      'get'    => 'show',
      'post'   => 'create',
      'put'    => 'update',
      'delete' => 'destroy'
    }
    DELIM = '/'

    def initialize(verb, path)
      @verb = verb.downcase
      @path = path
      @path_spl = path.gsub(/\/+/, '/').sub('/', '').split(DELIM, 3)
    end

    def valid?
      (path =~ VALID_PATH) && (verb =~ VALID_VERB)
    end

    def action
      namespace.method(route)
    end

    def id
      path_spl[1]
    end

    private

    attr_reader :path, :verb, :path_spl

    def resource
      path_spl[0].capitalize
    end

    def route
      ROUTE_MAP[verb]
    end

    def namespace
      Byg::Rest.const_get(resource)
    end
  end
end