# frozen_string_literal: true

module Vissen
  module Graphics
    # Engine
    #
    #
    class Engine
      MATCHER = ->(mod) { ->(e) { e.value == mod } }
      private_constant :MATCHER

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
    end
  end
end
