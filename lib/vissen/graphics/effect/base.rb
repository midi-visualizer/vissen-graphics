# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Effects are nothing more than Parameterized function blocks with a
      # special Renderer output type. Effects should, essentially, take
      # parameters as inputs and produce procs capable of rendering the effect
      # given a context.
      #
      # === Usage
      # The following example renders the same value in each context point.
      #
      #   class Solid < Base
      #     real :value, default: 0.5
      #
      #     def call(param)
      #       value = param.value
      #       proc do |context, output|
      #         context.each do |index|
      #           output.call value, index
      #         end
      #       end
      #     end
      #   end
      #
      class Base
        include Parameterized
        extend  Parameterized::DSL

        # @param  output [Value] the value type to use instead of `Renderer`.
        # @param  opts (see Parameterized).
        def initialize(output:, **opts)
          super(output: output || Output.new, **opts)
        end
      end
    end
  end
end
