module Vissen
  module Graphics
    # Context
    #
    #
    class Context
      def initialize(vixel_grid); end

      def create_effect(layer, effect_klass, **effect_config); end

      def configure(*params, value); end

      def update!(t); end
    end
  end
end
