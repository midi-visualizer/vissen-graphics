module Vissen
  module Graphics
    # Context
    #
    #
    class Context
      def initialize(vixel_stack)
        @params = {}
        # Create a mixer for each vixel layer
        @mixers = vixel_stack.layers.map { |layer| Mixer.new layer }
      end

      def create_effect(layer, effect_klass,
                        mix: [0.0, 1.0], **effect_config)
        @mixers[layer].create_effect(effect_klass, mix, **effect_config)
      end

      def attach(label, configurable)
        @params[label] = configurable
      end

      def configure(*params, value); end

      def update!(t); end
    end
  end
end
