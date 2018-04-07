module Vissen
  module Graphics
    module Effect
      # Gradient
      #
      # Generates a static gradient.
      class Gradient
        include Effect

        # Compute the factor that should be used to scale a in
        # #generate_gradient!
        A_FACTOR = 1.0 / Math.sqrt(2.0 * 0.5**2)

        DEFAULT_PARAMS = {
          mean:      0.5,
          angle:     Math::PI / 2,
          spread:    0.3
        }.freeze

        def initialize(grid, *)
          @gradient = grid.alloc_points { 0.0 }
          super
        end

        def configure(*)
          super
          generate_gradient!
        end

        def update(_, layer)
          layer.vixels.each_with_index { |v, i| v.p = @gradient[i] }
        end

        private

        # Generate Gradient
        #
        # Updates the gradient stored in @gradient using the current parameters
        # values.
        #
        # Note that this method has side-effects.
        def generate_gradient!
          x0 = grid.width  / 2.0
          y0 = grid.height / 2.0

          grid.each_position do |index, x, y|
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
