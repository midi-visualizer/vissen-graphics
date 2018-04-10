module Vissen
  module Graphics
    module Effect
      # Vignette
      #
      # Generates a static vignette.
      class Vignette
        include Effect

        DEFAULT_PARAMS = {
          x:         0.5,
          y:         0.5,
          radius:    0.5,
          blur:      0.1
        }.freeze

        def initialize(grid, *)
          @vignette = grid.alloc_points { 0.0 }
          super
        end

        def configure(*)
          super
          generate_gradient!
        end

        def update(_, layer)
          layer.vixels.each_with_index { |v, i| v.i = @vignette[i] }
        end

        private

        # Generate Gradient
        #
        # Updates the gradient stored in @gradient using the current parameters
        # values.
        #
        # Note that this method has side-effects.
        def generate_vignette!
          x0 = params[:x]
          y0 = params[:y]
          radius_squared = params[:radius]**2
          
          grid.distance_squared(x0, y0, @vignette)
          
          @vignette.map! do |distance_squared|
            distance_squared < radius_squared ? 1.0 : 0.0
          end
        end
      end
    end
  end
end
