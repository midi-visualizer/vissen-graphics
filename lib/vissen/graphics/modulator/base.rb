# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      # Modulators are nothing more than Parameterized function blocks.
      #
      # === Usage
      #
      #   class Inverter < Base
      #     real :input
      #     output Value::Real
      #
      #     def call(param)
      #       -param.input
      #     end
      #   end
      class Base
        include Parameterized
        extend  Parameterized::DSL
      end
    end
  end
end
