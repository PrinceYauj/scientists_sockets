# frozen_string_literal: true

module Byg
  module Actions
    module Inventions
      # get params[:route_id] from the delete route
      # invention will be deleted unconditionally (if exists)
      # returns inventions or nil
      class Destroy
        def destroy(params)
          Models::Invention[params[:route_id]]&.destroy
        end
      end
    end
  end
end
