# frozen_string_literal: true

module Vissen
  module Graphics
    class Parameter
      extend Forwardable

      def_delegators :@modulator, :value, :tainted?, :untaint!

      def initialize(value_klass)
        @constant = value_klass.new
        reset!
      end

      def reset!
        set @constant.class::DEFAULT
      end

      # @return [false] if the parameter is bound to a value object.
      # @reutrn [true] otherwise.
      def constant?
        @modulator == @constant
      end

      def modulator
        raise RuntimeError if constant?
        @modulator
      end

      # @param  value [Object] the value to set.
      # @return [self]
      def set(value)
        @constant.write value
        @modulator = @constant
        self
      end

      # TODO: validate the value type
      #
      # @param  obj [#value] the value object to bind to.
      # @return [self]
      def bind(obj)
        raise TypeError unless obj.respond_to?(:value)
        @modulator = obj
        self
      end
    end
  end
end
