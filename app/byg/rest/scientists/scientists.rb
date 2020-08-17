require_relative '/vagrant/app/byg/actions/scientists/index'
require_relative '/vagrant/app/byg/actions/scientists/show'
require_relative '/vagrant/app/byg/actions/scientists/create'
require_relative '/vagrant/app/byg/actions/scientists/destroy'
require_relative '/vagrant/app/byg/actions/scientists/update'

module Byg
  module Rest
    # provides functions to scientists actions
    module Scientists
      def self.show(params)
        Actions::Scientists::Show.new.show(params) if params['id']
        Actions::Scientists::Index.new.index
      end

      def self.create(params)
        Actions::Scientists::Create.new.create(params)
      end

      def self.destroy(params)
        Actions::Scientists::Destroy.new.destroy(params)
      end

      def self.update(params)
        Actions::Scientists::Update.new(params).update
      end
    end
  end
end
