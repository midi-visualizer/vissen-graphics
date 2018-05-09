# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Vignette
      #
      # Generates a static vignette.
      class Vignette < Base
        param pos: Value::Vec,
              radius: Value::Real,
              spread: Value::Real

        DEFAULTS = {
          pos:    [0.5, 0.5],
          radius: 0.5,
          spread: 0.1
        }.freeze

        def initialize(context, *)
          @vignette = context.alloc_points { 0.0 }
          super
        end

        def render
          x, y   = param.pos
          radius = param.radius
          spread = param.spread

          inner_radius_squared = spread >= radius ? 0.0 : (radius - spread)**2
          outer_radius_squared = radius**2

          context.distance_squared(x, y, @vignette).each do |d2|
            value =
              if d2 <= inner_radius_squared
                1.0
              elsif d2 >= outer_radius_squared
                0.0
              else
                distance = Math.sqrt d2
                (radius - distance) / spread
              end

            yield value
          end
        end
      end
    end
  end
end
