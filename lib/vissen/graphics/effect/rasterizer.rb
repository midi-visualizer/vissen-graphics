# frozen_string_literal: true

module Vissen
  module Graphics
    module Effect
      # Rasterizer
      #
      #
      class Rasterizer
        include Effect

        NUM_POINTS = 16
        # Points with intensity = nil are ignored completely
        Point = Struct.new :i, :x, :y, :s, :extra

        def initialize(context)
          super
          # Setup a number of blank rasterizer points
          @points = Array.new(NUM_POINTS) { Point.new }.freeze
        end

        def update(_t, layer)
          @update_handler&.call
          @points.each do |point|
            next unless point.i

            case point
            when Range
              draw_circle point, layer
            when Array
              draw_polygon point, layer
            else
              draw_point point, layer
            end
          end
        end

        def alloc_point
          @points.each do |point|
            return clean(point) unless point.i
          end
          # TODO: Define an Exception class, or return false?
          raise 'No point available'
        end

        def release_point(point)
          point.i = nil
        end

        private

        def clean(point)
          point.i = 0
          point.extra = nil
          point
        end

        def draw_point(point, layer)
          # Account for the special case when sigma2 = 0
          # TODO: derive a slightly more fancy threshold,
          # perhaps based on the distance between the pixels
          fn =
            if point.s <= 0.001
              ->(d2) { d2 <= 0.01 ? 1.0 : 0.0 }
            else
              c = -0.5 / point.s
              ->(d2) { Math.exp(c * d2) }
            end

          x = point.x
          y = point.y

          intensity = point.i

          layer.each do |vixel, row, column|
            x_i, y_i = context.position row, column
            d2 = (x - x_i)**2 + (y - y_i)**2

            vixel.i += intensity * fn.call(d2)
          end
        end

        def draw_polygon; end

        def draw_circle; end
      end
    end
  end
end
