# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      class Base < Parameterized
        include Effect

        def initialize(context, **initial_values)
          super
        end
      end
    end
  end
end
