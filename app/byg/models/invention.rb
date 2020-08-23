# frozen_string_literal: true

module Byg
  module Models
    # Invention model. Belongs to the scientist
    # Has parameters :id, :scientist_id, :name, :power, :created_at
    class Invention < Sequel::Model
      unrestrict_primary_key
      plugin :validation_helpers
      many_to_one :scientist

      def initialize(params = {})
        super
        @values[:created_at] = Time.now
      end

      def validate
        super
        validates_presence :scientist_id
        validates_type String, :name
        validates_max_length 255, :name
        validates_operator(:>, 0, :power)
      end
    end
  end
end
