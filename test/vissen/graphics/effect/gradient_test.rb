# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Effect::Gradient do
  subject { Vissen::Graphics::Effect::Gradient }

  let(:rows)     { 2 }
  let(:columns)  { 3 }
  let(:context)  { Vissen::Output::Context::Grid.new rows, columns }
  let(:grid)     { Vissen::Output::VixelBuffer.new context }
  let(:effect)   { subject.new }

  describe '#update' do
    before do
      effect.set :spread, 1.0
    end

    it 'draws a horizontal gradient' do
      effect.set :spread, 0.6666666667
      effect.set :angle, 0.0
      effect.tainted?

      effect.value.call(context, proc { |v, i| grid.vixels[i].p = v })

      assert_in_delta 0.029, grid[0, 0].p
      assert_in_delta 0.500, grid[0, 1].p
      assert_in_delta 0.971, grid[0, 2].p

      assert_in_delta 0.029, grid[1, 0].p
      assert_in_delta 0.500, grid[1, 1].p
      assert_in_delta 0.971, grid[1, 2].p
    end

    it 'draws a vertical gradient' do
      effect.set :angle, 0.25
      effect.tainted?

      effect.value.call(context, proc { |v, i| grid.vixels[i].p = v })

      deviation  = grid.height / 2 / Math.sqrt(2 * 0.5**2)
      top_row    = 0.5 + deviation
      bottom_row = 0.5 - deviation

      assert_in_epsilon top_row, grid[1, 0].p
      assert_in_epsilon top_row, grid[1, 1].p
      assert_in_epsilon top_row, grid[1, 2].p

      assert_in_epsilon bottom_row, grid[0, 0].p
      assert_in_epsilon bottom_row, grid[0, 1].p
      assert_in_epsilon bottom_row, grid[0, 2].p
    end
  end
end
