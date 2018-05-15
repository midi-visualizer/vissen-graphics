# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Sum < Base
        real :input_a
        real :input_b

        output Value::Real

        def call(param)
          param.input_a + param.input_b
        end
      end
    end
  end
end
