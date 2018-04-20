# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Effect Base
      #
      #
      class CyclicNoise
        include Vissen::Graphics::Effect

        ABSOLUTE       = false
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

          return unless new_params[:f] && !new_params[:w]

          params[:w] = 2 * Math::PI * params[:f]
        end

        def update(t, grid)
          amplitude = params[:amplitude]
          noise     = params[:noise]
          w         = params[:w]

          grid.vixels.each_with_index do |vixel, i|
            phase = noise * @phase[i]
            vixel.p += amplitude * Math.cos(t * w + phase)
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
