# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Sine < Base
        DEFAULTS = {
          frequency: 1.0
        }.freeze

        param frequency: Value::Real

        output Value::Real

        def update(t)
          Math.sin(t * param.frequency) * 0.5 + 0.5
        end
      end
    end
  end
end
