# frozen_string_literal: true

module Vissen
  module Graphics
    module Modulator
      class Base
        include Parameterized
        extend  Parameterized::DSL

        # def initialize(parameters:, output:, **setup)
        #   super(parameters: parameters, output: output, setup: setup)
        # end
      end
    end
  end
end
