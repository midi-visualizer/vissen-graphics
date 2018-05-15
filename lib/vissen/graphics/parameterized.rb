# frozen_string_literal: true

module Vissen
  module Graphics
    class Parameterized
      attr_reader :params

      DEFAULTS = {}.freeze

      # @param initial_values [Hash<Symbol, Object>] the initial values to use.
      #   If a value responds to #value it will be bound to.
      def initialize(**initial_values)
        @params = self.class.create_params
        @param_accessor = Object.new

        @params.each do |key, param|
          @param_accessor.define_singleton_method(key) { param.value }
        end

        self.class::DEFAULTS.merge(initial_values).each do |key, value|
          send (value.respond_to?(:value) ? :bind : :set), key, value
        end
      end

      # Bind the value of the given parameter to the value of a modulator.
      #
      # @param  param [Symbol] the parameter identifier.
      # @param  modulator [Modulator] the modulator to bind to.
      # @return [self]
      def bind(param, modulator)
        @params.fetch(param).bind modulator
        self
      end

      # Set the value of the given parameter to a constant.
      #
      # @param  param [Symbol] the parameter identifier.
      # @param  value [Object] the constant value to set.
      # @return [self]
      def set(param, value)
        @params.fetch(param).set value
        self
      end

      # @return [Object] an object with accessor methods defined for each
      #   parameter.
      def param
        @param_accessor
      end

      # @return [true] if any of the parameter values have been changed.
      # @return [false] otherwise.
      def tainted?
        @params.any? { |_, v| v.tainted? }
      end

      def untaint!
        @params.each { |_, v| v.untaint! }
      end

      class << self
        # Adds one or more parameters of specified value types to the class
        # param list.
        #
        # == Usage
        #
        #   class Example < Parameterized
        #     param input: Value::Real,
        #           offset: Value::Real
        #   end
        #
        # @param  hash [Hash] the parameter(s) to add.
        # @return [nil]
        def param(**hash)
          @params ||= {}
          hash.each do |key, value_klass|
            @params[key] = value_klass
          end
          nil
        end

        # @return [Hash<Symbol, Parameter>] a new hash containing one parameter
        #   object for each parameter key.
        def create_params
          return {}.freeze unless defined? :@params

          @params.each_with_object({}) { |(k, v), h| h[k] = Parameter.new v }
                 .freeze
        end
      end
    end
  end
end
