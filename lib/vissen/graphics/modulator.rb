# frozen_string_literal: true

module Vissen
  module Graphics
    # A modulator is any object which has an output value and responds to the
    # #update! method.
    module Modulator
      def initialize(output_value_klass, **args)
        super(**args)
        @value = output_value_klass.new
      end

      def update!(t)
        return unless tainted?

        @value.write update(t)
      end

      def value
        @value.value
      end

      def tainted?
        @value.tainted? || super
      end

      def untaint!
        return unless @value.tainted?
        @value.untaint!
        super
      end

      protected

      def update(_t)
        raise NotImplementedError
      end
    end
  end
end
