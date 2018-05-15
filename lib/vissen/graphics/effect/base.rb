# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      class Base
        include Parameterized
        extend  Parameterized::DSL

        def initialize(output:, **opts)
          super(output: output || Renderer.new, **opts)
        end
      end
    end
  end
end
