# frozen_string_literal: true

module Vissen
  module Graphics
    module Value
      class Real
        include Value

        DEFAULT = 0.0

        def write(new_value)
          super new_value.to_f
        end
      end
    end
  end
end
