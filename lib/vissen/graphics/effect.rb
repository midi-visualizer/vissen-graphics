# frozen_string_literal: true

module Vissen
  module Graphics
    # Graphics effects are parameterized functions of time that operate on a
    # vixel layer.
    #
    # Note that effects are single threaded and should not be configured from
    # multiple threads.
    module Effect
      attr_reader :context

      def initialize(context, *args)
        raise TypeError unless context.is_a? Output::Context
        @context = context

        super(*args)
      end

      def update(_t)
        raise NotImplementedError
      end

      def render
        raise NotImplementedError
      end
    end
  end
end
