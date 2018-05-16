# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      # The splitter modulator exposes each component in a Value::Vec type as an
      # input that can be set individually.
      #
      # TODO: consider changing the name to Merger or Combiner.
      class Splitter < Base
        real :input_a
        real :input_b

        output Value::Vec

        # @param  param [Parameterize::Accessor] the modulator parameters.
        # @return [Array<Numeric>]
        def call(param)
          [param.input_a, param.input_b]
        end
      end
    end
  end
end
