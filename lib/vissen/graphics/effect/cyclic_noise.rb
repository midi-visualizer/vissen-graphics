# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Effect Base
      #
      #
      class CyclicNoise
        include Effect

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

        def update(t)
          amplitude = params[:amplitude]
          noise     = params[:noise]
          w         = params[:w]

          @phase.each_with_index do |phase, i|
            yield amplitude * Math.cos(t * w + phase * noise), i
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
