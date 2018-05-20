# frozen_string_literal: true

module Vissen
  module Graphics
    module Mixer
      # The additive mixer adds a set ammount of the input value to each of the
      # two vixel components.
      class Additive < Base
        real :i
        real :p

        # @param  value [Numeric] the value to mix in.
        # @param  param [Parameterized::Accessor] the mixer parameters.
        # @param  vixel [Vissen::Output::Vixel] the vixel to update.
        def mix(value, param, vixel)
          vixel.i += value * param.i
          vixel.p += value * param.p
        end
      end
    end
  end
end
