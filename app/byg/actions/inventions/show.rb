# frozen_string_literal: true

module Byg
  module Actions
    module Inventions
      # get params[:route_id] from the get route
      # returns invention or nil
      class Show
        def show(params)
          Models::Invention[params[:route_id]]
        end
      end
    end
  end
end
