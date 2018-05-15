# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Ramp < Base
        real :period, default: 1.0
        real :offset
        real :t

        output Value::Real

        def call(param)
          (param.t - param.offset % param.period) / param.period
        end
      end
    end
  end
end
