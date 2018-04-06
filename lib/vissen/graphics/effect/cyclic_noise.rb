module Vissen
  module Graphics
    module Effect
      # Effect Base
      #
      #
      class CyclicNoise
        include Vissen::Graphics::Effect

        DEFAULT_PARAMS = {
          amplitude: 0.2,
          f:         0.4,
          noise:     1.0
        }.freeze

        def initialize(*)
          super
          @phase = random_phase
        end

        def configure(new_params)
          super

          if new_params[:f] && !new_params[:w]
            params[:w] = 2 * Math::PI * params[:f]
          end
        end

        def update(t, layer)
          amplitude = params[:amplitude]
          noise     = params[:noise]
          w         = params[:w]

          layer.vixels.each_with_index do |vixel, i|
            phase = noise * @phase[i]
            vixel.q += amplitude * Math.cos(t * w + phase)
          end
        end

        private

        def random_phase
          grid.alloc_points { rand * 2 * Math::PI }.freeze
        end
      end
    end
  end
end
