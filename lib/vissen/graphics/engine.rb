# frozen_string_literal: true

module Vissen
  module Graphics
    # Engine
    #
    #
    class Engine
      def initialize(mixers)
        @graph = Parameterized::Graph.new mixers
        @time_value = Parameterized::Value::Real.new

        mixers.each { |mixer| autobind_time mixer }
      end

      def time
        @time_value
      end

      def render(t)
        @time_value.write t
        @graph.update! { |mix| mix.call }
      end

      private

      # Each parameter named `:t` should automatically be bound to the time
      # value.
      #
      # TODO: avoid visiting each node more than once.
      def autobind_time(parameterized)
        if parameterized.respond_to?(:time_dependent?) &&
           parameterized.time_dependent?
          parameterized.bind_time(time)
        end

        parameterized.each_parameterized { |param| autobind_time param }
      end
    end
  end
end
