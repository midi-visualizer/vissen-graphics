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

        # rubocop:disable Metrics/AbcSize

        # @param  param [Parameterize::Accessor] the effect parameters.
        # @return [Proc]
        def call(param)
          angle  = param.angle * ANGLE_FACTOR
          spread = param.spread
          mean   = param.mean

          proc do |context, block|
            context.each_polar_offset(*context.center)
                   .with_index do |(distance, alpha), index|
              # Let a be the projection of the grid point onto
              # the gradient vector, scaled so that a = 1.0 in
              # the corners of a square
              a = Math.cos(angle - alpha) * distance * A_FACTOR

              block.call a * spread + mean, index
            end
          end
        end

        # rubocop:enable Metrics/AbcSize
      end
    end
  end
end
