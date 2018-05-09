# frozen_string_literal: true

module Vissen
  module Graphics
    module Value
      attr_reader :value

      DEFAULT = nil

      def initialize(value = nil)
        @value   = nil
        @tainted = true

        write (value || self.class::DEFAULT)
      end

      def write(new_value)
        return if new_value == @value

        @tainted = true
        @value   = new_value
        nil
      end

      def tainted?
        @tainted
      end

      def untaint!
        @tainted = false
      end
    end
  end
end
