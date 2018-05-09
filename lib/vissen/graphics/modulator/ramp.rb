# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Ramp < Base
        DEFAULTS = {
          period: 1.0
        }.freeze

        param period: Value::Real

        output Value::Real

        def update(t)
          (t % param.period) / param.period
        end
      end
    end
  end
end
