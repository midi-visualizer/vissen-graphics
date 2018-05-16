# frozen_string_literal: true

module Vissen
  module Graphics
    module Mixer
      class Multiplicative < Base
        bool :i
        bool :p

        def mix(value, param, vixel)
          vixel.i *= value if param.i
          vixel.p *= value if param.p
        end
      end
    end
  end
end
