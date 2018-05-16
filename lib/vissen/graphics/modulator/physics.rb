# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      # The physics modulator calculates the position at time t of a point,
      # given its initial position, velocity and acceleration at t_0.
      class Physics < Base
        real :acceleration
        real :velocity
        real :position
        real :t_0
        real :t

        output Value::Real

        # @param  param [Parameterize::Accessor] the modulator parameters.
        # @return [Numeric]
        def call(param)
          dt = param.t - param.t_0
          a  = param.acceleration
          v  = param.velocity

          v_t = v == 0.0 ? 0.0 : v * dt
          a_t = a == 0.0 ? 0.0 : a * dt**2

          param.position + v_t + a_t
        end
      end
    end
  end
end
