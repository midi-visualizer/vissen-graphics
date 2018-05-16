# frozen_string_literal: true

module Vissen
  module Graphics
    module Mixer
      class Additive < Base
        real :i
        real :p

        def mix(value, param, vixel)
          vixel.i += value * param.i
          vixel.p += value * param.p
        end
      end
    end
  end
end
