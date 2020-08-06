# frozen_string_literal: true

module Byg
  module Actions
    module Scientists
      # get params[:route_id] from the delete route
      # returns deleted scientist or nil
      class Destroy
        def destroy(params)
          Models::Scientist[params[:route_id]]&.destroy
        end
      end
    end
  end
end
