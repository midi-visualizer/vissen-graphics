# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Effect::Point do
  subject { Vissen::Graphics::Effect::Point }

  let(:rows)     { 2 }
  let(:columns)  { 3 }
  let(:context)  { Vissen::Output::Context::Grid.new rows, columns }
  let(:grid)     { Array.new context.point_count }
  let(:effect)   { subject.new }

  describe 'position' do
    before do
      effect.set :spread, 1.0
    end

    it 'renders a point at the specified position' do
      effect.set :position, [0.0, 1.0]
      effect.tainted?
      effect.value.call(context, proc { |v, i| grid[i] = v })

      assert_in_delta 0.606, grid[context.index_from(0, 0)]
      assert_in_delta 0.535, grid[context.index_from(0, 1)]
      assert_in_delta 0.367, grid[context.index_from(0, 2)]

      assert_in_delta 0.882, grid[context.index_from(1, 0)]
      assert_in_delta 0.778, grid[context.index_from(1, 1)]
      assert_in_delta 0.535, grid[context.index_from(1, 2)]
    end
  end

  describe 'spread' do
    it 'renders with the specified spread' do
      effect.set :spread, 2.0
      effect.tainted?
      effect.value.call(context, proc { |v, i| grid[i] = v })

      assert_in_delta 0.882, grid[context.index_from(0, 0)]
      assert_in_delta 0.939, grid[context.index_from(0, 1)]
      assert_in_delta 0.882, grid[context.index_from(0, 2)]

      assert_in_delta 0.939, grid[context.index_from(1, 0)]
      assert_in_delta 1.000, grid[context.index_from(1, 1)]
      assert_in_delta 0.939, grid[context.index_from(1, 2)]
    end

    it 'can produce a sharp point' do
      effect.set :spread, 0.0
      effect.set :position, context.position(0)
      effect.tainted?
      effect.value.call(context, proc { |v, i| grid[i] = v })

      assert_in_delta 1.0, grid[context.index_from(0, 0)]
      assert_in_delta 0.0, grid[context.index_from(0, 1)]
      assert_in_delta 0.0, grid[context.index_from(0, 2)]

      assert_in_delta 0.0, grid[context.index_from(1, 0)]
      assert_in_delta 0.0, grid[context.index_from(1, 1)]
      assert_in_delta 0.0, grid[context.index_from(1, 2)]
    end
  end

  describe 'value' do
    it 'renders with the specified max value' do
      effect.set :value, 0.5
      effect.tainted?
      effect.value.call(context, proc { |v, i| grid[i] = v })

      assert_in_delta 0.143, grid[context.index_from(0, 0)]
      assert_in_delta 0.267, grid[context.index_from(0, 1)]
      assert_in_delta 0.143, grid[context.index_from(0, 2)]

      assert_in_delta 0.267, grid[context.index_from(1, 0)]
      assert_in_delta 0.500, grid[context.index_from(1, 1)]
      assert_in_delta 0.267, grid[context.index_from(1, 2)]
    end
  end
end
