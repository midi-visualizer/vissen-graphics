# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      # The bias modulator takes an input, multiplies it with an amplitude and
      # adds an offset to produce its output.
      class Bias < Base
        real :input
        real :offset
        real :amplitude, default: 1.0

        output Value::Real

        def call(param)
          param.input * param.amplitude + param.offset
        end
      end
    end
  end
end
