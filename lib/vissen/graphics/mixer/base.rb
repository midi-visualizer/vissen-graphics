# frozen_string_literal: true

module Vissen
  module Graphics
    module Mixer
      # Mixers are modeled as parameterized functions that take an effect
      # output, posibly some other parameters and produces a mixer output. When
      # called, the mixer output should affect the output layer stored in the
      # mixer acording the the rendered effect and the particular mixer
      # implementation.
      class Base
        include Parameterized
        extend  Parameterized::DSL

        # @param  output [Value] the value type to use instead of
        #   `Mixer::Output`.
        # @param  opts (see Parameterized).
        def initialize(layer, parameters:, output:, **opts)
          @layer  = layer
          @buffer = layer.context.alloc_points { 0.0 }
          parameters =
            parameters.merge(effect: Parameter.new(Effect::Output))

          super(parameters: parameters, output: output || Output.new, **opts)
        end

        # @param  param [Parameterized::Accessor] the mixer parameters.
        # @return [Proc]
        def call(param)
          effect  = param.effect
          vixels  = @layer.elements
          context = @layer.context

          effect.call(context, proc { |v, i| @buffer[i] = v })

          proc do
            @buffer.each_with_index { |v, i| mix v, param, vixels[i] }
          end
        end

        # @param  _value [Numeric] the value to mix in.
        # @param  _param [Parameterized::Accessor] the mixer parameters.
        # @param  _vixel [Vissen::Output::Vixel] the vixel to update.
        def mix(_value, _param, _vixel); end
      end
    end
  end
end
