# frozen_string_literal: true

module Byg
  module Classes
    # Validates parsed http request
    # Routes parsed http request to corresponding action in a business logic
    # Returns action's method name
    class Router
      VALID_PATH = %r{\A/+(scientists|inventions)(/+-?\d+\s*)?\z}.freeze
      VALID_VERB = /\A\s*(GET|POST|PUT|DELETE)\s*/i.freeze
      ROUTE_MAP = {
        'get' => 'show',
        'post' => 'create',
        'put' => 'update',
        'delete' => 'destroy'
      }.freeze
      DELIM = '/'

      def initialize(verb, path)
        @verb = verb.downcase
        @path = path
        @path_spl = path.gsub(%r{/+}, '/').sub('/', '').split(DELIM, 3)
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
end
