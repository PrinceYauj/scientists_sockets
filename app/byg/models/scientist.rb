# frozen_string_literal: true

module Byg
  module Models
    # scientist model. Has many inventions
    # Has parameters :id, :madness, :attempts, :created_at
    class Scientist < Sequel::Model
      unrestrict_primary_key
      plugin :validation_helpers
      one_to_many :inventions

      def initialize(params = {})
        super
        @values[:created_at] = Time.now
      end

      def validate
        super
        validates_operator(:>, 0, %i[madness attempts])
      end
    end
  end
end
