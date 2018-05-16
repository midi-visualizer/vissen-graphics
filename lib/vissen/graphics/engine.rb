# frozen_string_literal: true

module Vissen
  module Graphics
    # Engine
    #
    #
    class Engine
      def initialize(mixers)
        @mixers     = mixers
        @mutex      = Mutex.new
        @time_value = Parameterized::Value::Real.new
      end

      def time
        @time_value
      end

      def render(t)
        @time_value.write t

        @mutex.synchronize do
          @mixers.each(&:tainted?)
          @mixers.each(&:untaint!)
        end
      end

      private

      # Each parameter named `:t` should automatically be bound to the time
      # value.
      def autobind_time(parameterized); end
    end
  end
end
