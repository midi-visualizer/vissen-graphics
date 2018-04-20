# frozen_string_literal: true

module Vissen
  module Graphics
    class Mixer
      def initialize(context)
        @context = context
        @effects = []
      end

      def configure; end

      def create_effect; end

      def update(t); end
    end
  end
end
