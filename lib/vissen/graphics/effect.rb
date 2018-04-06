module Vissen
  module Graphics
    # Effect
    #
    # Graphics effects are parameterized functions of time that operate on a
    # vixel layer.
    #
    # Note that effects are single threaded and should not be configured from
    # multiple threads.
    module Effect
      DEFAULT_PARAMS = {}.freeze

      attr_reader :params

      def initialize(grid, params = {})
        raise TypeError unless grid.is_a? Output::Grid

        @grid   = grid
        @params = self.class::DEFAULT_PARAMS.dup

        configure params
      end

      def configure(params)
        @params.merge! params
      end

      def update(_t, _layer)
        raise NotImplementedError
      end

      protected

      attr_reader :grid
    end
  end
end
