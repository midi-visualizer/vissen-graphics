# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Vignette
      #
      # Generates a vignette.
      class Vignette < Base
        vec  :pos, default: [0.5, 0.5]
        real :radius, default: 0.5
        real :spread, default: 0.1

        def call(param)
          x, y     = param.pos
          value_fn = create_value_function param.radius, param.spread

          proc do |context, block|
            context.distance_squared(x, y).with_index do |d2, index|
              value = value_fn.call d2
              block.call value, index
            end
          end

          private

          def create_value_function(radius, spread)
            inner_r_squared = spread >= radius ? 0.0 : (radius - spread)**2
            outer_r_squared = radius**2

            proc do |d2|
              if d2 <= inner_r_squared
                1.0
              elsif d2 >= outer_r_squared
                0.0
              else
                distance = Math.sqrt d2
                (radius - distance) / spread
              end
            end
          end
        end
      end
    end
  end
end
