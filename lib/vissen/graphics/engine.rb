# frozen_string_literal: true

module Vissen
  module Graphics
    # Engine
    #
    #
    class Engine
      # @param  mixers [Array<Mixer::Base>] the mixers to render.
      def initialize(mixers)
        @graph = Parameterized::Graph.new mixers
        @time_value = Parameterized::Value::Real.new

        mixers.each { |mixer| autobind_time mixer }
      end

      # @return [Parameterized::Value] the current time value.
      def time
        @time_value
      end

      # Renders the mixers and updates the output vixel buffers.
      #
      # @param  t [Numeric] the current time.
      def render(t)
        @time_value.write t
        @graph.update!(&:call)
      end

      private

      # Each parameter named `:t` should automatically be bound to the time
      # value.
      #
      # TODO: avoid visiting each node more than once.
      def autobind_time(node)
        # Only modulators should depend on time.
        if node.is_a?(Modulator::Base) && node.time_dependent?
          node.bind_time(time)
        end

        node.each_parameterized { |param| autobind_time param }
      end
    end
  end
end
