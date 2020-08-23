require_relative '/vagrant/app/byg/actions/inventions/index'
require_relative '/vagrant/app/byg/actions/inventions/show'
require_relative '/vagrant/app/byg/actions/inventions/create'
require_relative '/vagrant/app/byg/actions/inventions/destroy'
require_relative '/vagrant/app/byg/actions/inventions/update'

module Byg
  module Rest
    # provides functions to inventions actions
    module Inventions
      def self.show(params)
        return Actions::Inventions::Show.new.show(params) if params['route_id']
        Actions::Inventions::Index.new.index
      end

      def self.create(params)
        Actions::Inventions::Create.new.create(params)
      end

      def self.destroy(params)
        Actions::Inventions::Destroy.new.destroy(params)
      end

      def self.update(params)
        Actions::Inventions::Update.new(params).update
      end
    end
  end
end
