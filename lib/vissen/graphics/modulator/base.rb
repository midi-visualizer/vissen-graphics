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

        # @return [true] if the modulator has a parameter named t.
        # @return [false] otherwise.
        def time_dependent?
          parameter? :t
        end

        # Binds the t parameter to the given target.
        #
        # @see Parameterized#bind
        #
        # @param  target [#value] the time source to bind to.
        # @return see #bind
        def bind_time(target)
          bind :t, target
        end
      end
    end
  end
end
