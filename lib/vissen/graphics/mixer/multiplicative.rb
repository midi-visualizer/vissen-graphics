# frozen_string_literal: true

module Vissen
  module Graphics
    module Mixer
      # The multiplicative mixer multiplies each vixel component with the input
      # value if the corrseponding component parameter is set to true.
      class Multiplicative < Base
        bool :i
        bool :p

        # @param  value [Numeric] the value to mix in.
        # @param  param [Parameterized::Accessor] the mixer parameters.
        # @param  vixel [Vissen::Output::Vixel] the vixel to update.
        def mix(value, param, vixel)
          vixel.i *= value if param.i
          vixel.p *= value if param.p
        end
      end
    end
  end
end
