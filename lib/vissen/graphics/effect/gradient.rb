# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Generates a static gradient.
      class Gradient < Base
        real :mean, default: 0.5
        real :angle
        real :spread, default: 1.0

        # Compute the factor that should be used to scale a in
        # #generate_gradient!
        A_FACTOR = 1.0 / Math.sqrt(2.0 * 0.5**2)
        private_constant :A_FACTOR

        ANGLE_FACTOR = (2.0 * Math::PI)

        def call(param)
          angle  = param.angle * ANGLE_FACTOR
          spread = param.spread
          mean   = param.mean

          proc do |context, proc|
            x0, y0 = context.center
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

              proc.call a * spread + mean, index
            end
          end
        end
      end
    end
  end
end
