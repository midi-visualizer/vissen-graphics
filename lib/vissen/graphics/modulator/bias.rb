# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
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
