# frozen_string_literal: true

module Vissen
  module Graphics
    module Value
      class Vec
        include Value

        DEFAULT = [0.0, 0.0].freeze

        def write(new_value)
          super new_value.map(&:to_f)
        end
      end
    end
  end
end
