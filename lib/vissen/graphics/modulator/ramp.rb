# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      # The ramp produces a saw tooth signal with a given period that can be
      # offset to start at t_0.
      class Ramp < Base
        real :period, default: 1.0
        real :t_0
        real :t

        output Value::Real

        # @param  param [Parameterize::Accessor] the modulator parameters.
        # @return [Numeric]
        def call(param)
          (param.t - param.t_0 % param.period) / param.period
        end
      end
    end
  end
end
