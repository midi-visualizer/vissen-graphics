# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Sum < Base
        param input_a: Value::Real
        param input_b: Value::Real

        output Value::Real

        def update(_)
          param.input_a + param.input_b
        end
      end
    end
  end
end
