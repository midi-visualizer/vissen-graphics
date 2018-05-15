# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Generates a static gradient.
      class Point < Base
        vec  :position, default: [0.5, 0.5]
        real :value, default: 1.0
        real :spread, default: 0.2

        def call(param)
          x, y      = param.position
          max_value = param.value

          fn = create_threshold_function param.spread

          proc do |context, block|
            context.each_position do |index, x_i, y_i|
              d2 = (x - x_i)**2 + (y - y_i)**2
              block.call max_value * fn.call(d2), index
            end
          end
        end

        private

        def create_threshold_function(spread)
          if spread <= 0.001
            ->(d2) { d2 <= 0.001 ? 1.0 : 0.0 }
          else
            c = -0.5 / spread
            ->(d2) { Math.exp(c * d2) }
          end
        end
      end
    end
  end
end
