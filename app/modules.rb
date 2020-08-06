module Byg
  module Rest
    module Scientists
      def self.show(params)
        return "show action called with #{params["id"]}" if params["id"]
        "index action called"
      end

      def self.create(params)
        "create action called with #{params}"
      end

      def self.destroy(params)
        "destroy action called with #{params}"
      end

      def self.update(params)
        "update action called with #{params}"
      end
    end
  end
end

module Byg
  module Rest
    module Inventions
      def self.show(params)
        return "show action called with #{params["id"]}" if params["id"]
        "index action called"
      end

      def self.create(params)
        "create action called with #{params}"
      end

      def self.destroy(params)
        "destroy action called with #{params}"
      end

      def self.update(params)
        "update action called with #{params}"
      end
    end
  end
end
