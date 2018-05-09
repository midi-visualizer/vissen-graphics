# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Bias < Base
        DEFAULTS = {
          amplitude: 1.0
        }.freeze

        param input: Value::Real
        param offset: Value::Real
        param amplitude: Value::Real

        output Value::Real

        def update(_)
          param.input * param.amplitude + param.offset
        end
      end
    end
  end
end
