# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Effect::Gradient do
  subject { Vissen::Graphics::Effect::Gradient }

  let(:layers)   { 1 }
  let(:rows)     { 2 }
  let(:columns)  { 3 }
  let(:palettes) { [[]] }
  let(:context)  { Vissen::Output::Context::Grid.new 2, 3 }
  let(:grid)     { Vissen::Output::VixelBuffer.new context }
  let(:effect)   { subject.new context }
  let(:t)        { 0 }

  describe '#configure' do
    it 'updates the parameters' do
      refute_equal 0.5, effect.params[:angle]
      effect.configure angle: 0.5
      assert_equal 0.5, effect.params[:angle]
    end
  end

  describe '#update' do
    before do
      effect.configure spread: 1.0
    end

    it 'draws a horizontal gradient' do
      effect.configure angle: 0.0
      effect.update t, grid

      assert_equal 0.0, grid[0, 0].p
      assert_equal 0.5, grid[0, 1].p
      assert_equal 1.0, grid[0, 2].p

      assert_equal 0.0, grid[1, 0].p
      assert_equal 0.5, grid[1, 1].p
      assert_equal 1.0, grid[1, 2].p
    end

    it 'draws a vertical gradient' do
      effect.configure angle: Math::PI / 2
      effect.update t, grid

      deviation = grid.height / 2 / Math.sqrt(2 * 0.5**2)
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
