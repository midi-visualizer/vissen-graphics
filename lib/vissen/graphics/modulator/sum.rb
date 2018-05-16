# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      # The Sum modulator produces a sum of two inputs.
      class Sum < Base
        real :input_a
        real :input_b

        output Value::Real

        # @param  param [Parameterize::Accessor] the modulator parameters.
        # @return [Numeric]
        def call(param)
          param.input_a + param.input_b
        end
      end
    end
  end
end
