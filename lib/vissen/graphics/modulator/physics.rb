# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Physics < Base
        real :acceleration
        real :velocity
        real :position
        real :offset
        real :t

        output Value::Real

        def call(param)
          dt = param.t - param.offset
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
