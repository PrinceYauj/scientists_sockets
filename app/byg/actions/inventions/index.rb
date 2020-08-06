# frozen_string_literal: true

module Byg
  module Actions
    module Inventions
      # returns list of invention or an empty array
      class Index
        def index
          Models::Invention.all
        end
      end
    end
  end
end
