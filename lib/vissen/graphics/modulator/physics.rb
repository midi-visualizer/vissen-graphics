# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Physics < Base
        param acceleration: Value::Real,
              velocity:     Value::Real,
              position:     Value::Real

        DEFAULTS = {
          acceleration: -9.8,
          position:     1.0
        }.freeze

        output Value::Vec

        def update(t)
          a = param.acceleration
          v = param.velocity

          v_t = v == 0.0 ? 0.0 : v * t
          a_t = a == 0.0 ? 0.0 : a * t**2

          param.position + v_t + a_t
        end
      end
    end
  end
end
