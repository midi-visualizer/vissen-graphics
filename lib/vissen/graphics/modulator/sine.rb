# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      # The sine modulator produces a sine wave with a given frequency and
      # phase.
      class Sine < Base
        real :frequency, default: 1.0
        real :phase
        real :t

        output Value::Real

        def call(param)
          angle = (param.t * param.frequency + param.phase) * Math::PI * 2.0
          Math.sin(angle) * 0.5 + 0.5
        end
      end
    end
  end
end
