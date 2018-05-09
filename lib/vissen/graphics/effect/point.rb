# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Generates a static gradient.
      class Point < Base
        param position: Value::Vec,
              value:    Value::Real,
              spread:   Value::Real

        DEFAULTS = {
          position: [0.5, 0.5],
          value: 1.0
          spread: 0.2
        }.freeze

        def render
          x, y = param.position
          max_value = param.value
          spread = param.spread
          
          fn =
            if spread <= 0.001
              ->(d2) { d2 <= 0.01 ? 1.0 : 0.0 }
            else
              c = -0.5 / spread
              ->(d2) { Math.exp(c * d2) }
            end
          
          context.each_position do |index, x_i, y_i|
            d2 = (x - x_i)**2 + (y - y_i)**2
            yield max_value * fn.call d2
          end
        end
      end
    end
  end
end
