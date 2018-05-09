# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Base < Parameterized
        include Modulator

        DEFAULTS = {}.freeze

        def initialize(**initial_values)
          super(self.class.output_value_klass, **initial_values)
        end

        class << self
          attr_reader :output_value_klass

          def output(klass)
            @output_value_klass = klass
          end
        end
      end
    end
  end
end
