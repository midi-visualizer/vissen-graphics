# frozen_string_literal: true

module Vissen
  module Graphics
    module Mixer
      # The absolute mixer sets the output value absolutely, if the component
      # parameter is set to true. Both vixel components _i_ and _p_ are
      # supported.
      class Absolute < Base
        bool :i
        bool :p

        # @param  value [Numeric] the value to mix in.
        # @param  param [Parameterized::Accessor] the mixer parameters.
        # @param  vixel [Vissen::Output::Vixel] the vixel to update.
        def mix(value, param, vixel)
          vixel.i = value if param.i
          vixel.p = value if param.p
        end
      end
    end
  end
end
