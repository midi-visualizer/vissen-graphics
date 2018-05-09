# frozen_string_literal: true

module Vissen
  module Graphics
    class Mixer < Parameterized
      param mix_i: Value::Real
      param mix_p: Value::Real

      attr_reader :effect

      def initialize(effect, vixel_buffer, **initial_values)
        raise TypeError unless vixel_buffer.share_context? effect
        super(**initial_values)

        @effect       = effect
        @vixel_buffer = vixel_buffer
      end

      def render!
        w_i, w_p = param.mix_i, param.mix_p
        vixels   = @vixel_buffer.elements
        @effect.render do |v, i|
          vixel = vixels[i]
          vixel.i += w_i * v
          vixel.p += w_p * v
        end
      end
    end
  end
end
