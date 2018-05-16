# frozen_string_literal: true

module Vissen
  module Graphics
    # The effect mixer takes an effect renderer as input and applies it to each
    # vixel in a vixel layer.
    class Mixer
      include Parameterized
      extend  Parameterized::DSL

      real  :mix_i
      real  :mix_p
      param :effect, Renderer

      output Value::Bool

      # @param  vixel_buffer [VixelBuffer] the vixel layer the apply the effect
      #   to.
      # @param  opts (see Parameterized)
      def initialize(vixel_buffer, **opts)
        super(**opts)
        @vixel_buffer = vixel_buffer
      end

      # @param  param [Parameterize::Accessor] the mixer parameters.
      # @return [true]
      def call(param)
        mixer = create_mixer @vixel_buffer.elements, param.mix_i, param.mix_p
        # Use the proc stored in the effect value to render
        # the effect in the vixel buffer context.
        param.effect.call @vixel_buffer.context, mixer
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
