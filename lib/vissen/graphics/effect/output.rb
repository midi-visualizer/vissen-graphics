# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # The effect output encapsulates a proc that has been setup by an effect
      # to produce a value for each point in a context.
      #
      # === Usage
      # The following example does not include the additional code required to
      # interface with the Parameterized module.
      #
      #   class SomeEffect
      #     output Renderer
      #
      #     def call(param)
      #       proc do |context, block|
      #         context.each_position do |x, y, index|
      #           block.call (x - y), index
      #         end
      #       end
      #     end
      #   end
      #
      class Output
        include Parameterized::Value

        # @return [Proc] the default effect output takes a context and a block
        #   and does nothing.
        DEFAULT = ->(_, _) {}

        # Accepts a proc with arity two that accepts a context and another proc.
        # When called, the given proc should in turn be called once for each
        # point defined in the context with the value and index of that point as
        # arguments.
        #
        # @param  new_proc [Proc] the new proc to use.
        # @return see Parameterized::Value
        def write(new_proc)
          raise TypeError unless new_proc.is_a?(Proc) && new_proc.arity == 2
          super new_proc
        end
      end
    end
  end
end
