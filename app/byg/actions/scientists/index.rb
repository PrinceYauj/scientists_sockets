# frozen_string_literal: true

module Byg
  module Actions
    module Scientists
      # returns scientists list or empty array
      class Index
        def index
          Models::Scientist.all
        end
      end
    end
  end
end
