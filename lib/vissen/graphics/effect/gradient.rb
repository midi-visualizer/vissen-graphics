module Vissen
  module Graphics
    module Effect
      # Generates a static gradient.
      class Gradient
        include Effect

        DEFAULT_PARAMS = {
          mean:      0.5,
          angle:     Math::PI / 2,
          spread:    0.3
        }.freeze

        # @see Effect
        def initialize(context, *)
          @gradient = context.alloc_points { 0.0 }
          super
        end

        # @see Effect
        def configure(*)
          super
          generate_gradient!
        end

        # @see Effect
        def update(_, layer)
          layer.vixels.each_with_index { |v, i| v.p = @gradient[i] }
        end

        private

        # Compute the factor that should be used to scale a in
        # #generate_gradient!
        A_FACTOR = 1.0 / Math.sqrt(2.0 * 0.5**2)

        # Generate Gradient
        #
        # Updates the gradient stored in @gradient using the current parameters
        # values.
        #
        # Note that this method has side-effects.
        def generate_gradient!
          x0 = context.width  / 2.0
          y0 = context.height / 2.0

          context.each_position do |index, x, y|
            # Calculate the offset to the center of the gradient
            x_offset = x - x0
            y_offset = y - y0
            # Find the angle alpha as the angle of the offset
            # vector and theta as the difference between the
            # gradient angle and alpha
            alpha = Math.atan2 y_offset, x_offset
            theta = params[:angle] - alpha
            # Let a be the projection of the grid point onto
            # the gradient vector, scaled so that a = 1.0 in
            # the corners of a square
            a = Math.cos(theta) *
                Math.sqrt(x_offset**2 + y_offset**2) * A_FACTOR
            @gradient[index] = a * params[:spread] + params[:mean]
          end
        end
      end
    end
  end
end
