# frozen_string_literal: true

module Byg
  module Actions
    module Scientists
      # get params[:route_id] from the get route
      # returns scientist or nil
      class Show
        def show(params)
          Models::Scientist[params[:route_id]]
        end
      end
    end
  end
end
