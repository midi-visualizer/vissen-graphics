module Vissen
  module Graphics
    # Effect
    #
    # Graphics effects are parameterized functions of time that operate on a
    # vixel layer.
    module Effect
      DEFAULT_PARAMS = {}
      
      def initialize(grid, params = {})
        raise TypeError unless grid.is_a? Output::Grid
        
        @grid   = grid
        @params = self.class::DEFAULT_PARAMS.dup
      
        configure params
      end
      
      attr_reader :params
      
      def configure(params)
        @params.merge! params
      end
      
      def update(t, layer)
        raise NotImplementedError
      end
      
      protected
      
      attr_reader :grid
    end
  end
end
