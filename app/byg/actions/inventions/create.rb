# frozen_string_literal: true

module Byg
  module Actions
    module Inventions
      # get params from the body of POST request
      # returns created invention or nil
      class Create
        def create(params)
          Models::Invention.create(params)
        end
      end
    end
  end
end
