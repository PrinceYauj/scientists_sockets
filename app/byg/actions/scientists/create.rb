# frozen_string_literal: true

module Byg
  module Actions
    module Scientists
      # get params from the body of POST request
      # returns created scientist or nil
      class Create
        def create(params)
          Models::Scientist.create(params)
        end
      end
    end
  end
end
