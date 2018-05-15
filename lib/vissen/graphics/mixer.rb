# frozen_string_literal: true

module Vissen
  module Graphics
    class Mixer
      include Parameterized
      extend  Parameterized::DSL

      real :mix_i
      real :mix_p
      param :effect, Renderer

      output Value::Bool

      attr_reader :effect

      def initialize(vixel_buffer, **opts)
        super(**opts)
        @vixel_buffer = vixel_buffer
      end

      def call(param)
        mixer = create_mixer @vixel_buffer.elements, param.mix_i, param.mix_p
        param.effect.call(@vixel_buffer.context, mixer)
        true
      end

      private

      def create_mixer(vixels, w_i, w_p)
        proc do |v, i|
          vixel = vixels[i]
          vixel.i += w_i * v
          vixel.p += w_p * v
        end
      end
    end
  end
end
