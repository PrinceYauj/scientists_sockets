require_relative '/vagrant/app/byg/actions/inventions/index.rb'
require_relative '/vagrant/app/byg/actions/inventions/show.rb'
require_relative '/vagrant/app/byg/actions/inventions/create.rb'
require_relative '/vagrant/app/byg/actions/inventions/destroy.rb'
require_relative '/vagrant/app/byg/actions/inventions/update.rb'

module Byg
  module Rest
    # provides functions to inventions actions
    module Inventions
      def self.show(params)
        Actions::Inventions::Show.new.show(params) if params['id']
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
