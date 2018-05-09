# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Generates a static gradient.
      class Gradient < Base
        param mean:   Value::Real,
              angle:  Value::Real,
              spread: Value::Real

        # Compute the factor that should be used to scale a in
        # #generate_gradient!
        A_FACTOR = 1.0 / Math.sqrt(2.0 * 0.5**2)
        private_constant :A_FACTOR

        DEFAULTS = {
          mean:   0.5,
          spread: 1.0
        }.freeze

        # @see Effect
        def update(_)
          x0, y0 = context.center

          angle  = param.angle
          spread = param.spread
          mean   = param.mean

          context.each_position do |index, x, y|
            # Calculate the offset to the center of the gradient
            x_offset = x - x0
            y_offset = y - y0
            # Find the angle alpha as the angle of the offset
            # vector and theta as the difference between the
            # gradient angle and alpha
            alpha = Math.atan2 y_offset, x_offset
            theta = angle - alpha
            # Let a be the projection of the grid point onto
            # the gradient vector, scaled so that a = 1.0 in
            # the corners of a square
            a = Math.cos(theta) *
                Math.sqrt(x_offset**2 + y_offset**2) * A_FACTOR

            yield a * spread + mean, index
          end
        end
        
        def render(&block)
          update(nil, &block)
        end
      end
    end
  end
end
