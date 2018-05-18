# frozen_string_literal: true

module Vissen
  module Graphics
    module Mixer
      class Base
        include Parameterized
        extend  Parameterized::DSL

        param :effect, Effect::Output

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

        def call(param)
          effect  = param.effect
          vixels  = @layer.elements
          context = @layer.context

          effect.call(context, proc { |v, i| @buffer[i] = v })

          proc do
            @buffer.each_with_index { |v, i| mix v, param, vixels[i] }
          end
        end

        def mix(_value, _param, _vixel); end
      end
    end
  end
end
