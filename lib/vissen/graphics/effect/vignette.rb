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
          spread:    0.1
        }.freeze

        def initialize(context, *)
          @vignette = context.alloc_points { 0.0 }
          super
        end

        def configure(*)
          super
          generate_vignette!
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
          x0     = params[:x]
          y0     = params[:y]
          radius = params[:radius]
          spread = params[:spread]

          inner_radius_squared = spread >= radius ? 0.0 : (radius - spread)**2
          outer_radius_squared = radius**2
          
          context.distance_squared x0, y0, @vignette
          
          @vignette.map! do |distance_squared|
            
            if distance_squared <= inner_radius_squared
              1.0
            elsif distance_squared >= outer_radius_squared
              0.0
            else
              distance = Math.sqrt(distance_squared)
              (radius - distance) / spread
            end
          end
        end
      end
    end
  end
end
