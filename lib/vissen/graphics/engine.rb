module Vissen
  module Graphics
    # Engine
    #
    #
    class Engine
      def initialize(vixel_stack)
        @vixel_stack = vixel_stack
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

      def render(t, pixel_cloud)
        # Update all the animations
        
        # Render all effects
        
        # Finally render the vixels to the pixel cloud
        @vixel_stack.render pixel_cloud
      end
    end
  end
end
