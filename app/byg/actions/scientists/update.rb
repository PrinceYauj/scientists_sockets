# frozen_string_literal: true

module Byg
  module Actions
    module Scientists
      # get params[:route_id] from the put route
      # get other params from the request body
      # returns updated scientist or nil
      # id CAN be updated. Cascade updating restricted
      # created_at CAN NOT be updated
      class Update
        def initialize(params)
          params.delete(:created_at)
          @route_id = params.delete(:route_id)
          @id = params.delete(:id)
          @params = params
        end

        def update
          return record if params.empty? && id.nil?

          DB.transaction do
            record.update(params)
            update_id
          end
          id ? Models::Scientist[id] : record
        end

        private

        attr_reader :route_id, :id, :params

        def record
          Models::Scientist.with_pk!(route_id)
        end

        def update_id
          DB[:scientists].where(id: route_id).update(id: id) if id
        end
      end
    end
  end
end
