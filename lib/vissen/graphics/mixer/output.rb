# frozen_string_literal: true

module Vissen
  module Graphics
    module Mixer
      # The mixer output encapsulates a proc that has been setup by ...
      #
      # === Usage
      # The following example does not include the additional code required to
      # interface with the Parameterized module.
      #
      #   class IntensityMixer
      #     param :effect, Renderer
      #     output Mixer
      #
      #     def call(param)
      #       renderer = param.effect
      #       proc do |layer|
      #         vixels = layer.elements
      #         effect.call(layer.context, ->(value, index)
      #           vixels[index].i = value
      #         })
      #       end
      #     end
      #   end
      #
      class Output
        include Parameterized::Value

        DEFAULT = -> {}

        # Accepts a proc with arity one that accepts a vixel buffer. When
        # called, the layer should be modified accordingly.
        #
        # @param  new_proc [Proc] the new proc to use.
        # @return see Parameterized::Value
        def write(new_proc)
          raise TypeError unless new_proc.is_a?(Proc) && new_proc.arity.zero?
          super new_proc
        end
      end
    end
  end
end
