require 'test_helper'

describe Vissen::Graphics::Effect::Gradient do
  subject { Vissen::Graphics::Effect::Gradient }

  let(:layers)   { 1 }
  let(:rows)     { 2 }
  let(:columns)  { 3 }
  let(:palettes) { [[]] }
  let(:grid) { Vissen::Output::VixelGrid.new rows, columns, layers, palettes }
  let(:layer)    { grid.layers[0] }
  let(:effect)   { subject.new grid }
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
      effect.update t, layer

      assert_equal 0.0, layer[0, 0].q
      assert_equal 0.5, layer[0, 1].q
      assert_equal 1.0, layer[0, 2].q

      assert_equal 0.0, layer[1, 0].q
      assert_equal 0.5, layer[1, 1].q
      assert_equal 1.0, layer[1, 2].q
    end

    it 'draws a vertical gradient' do
      effect.configure angle: Math::PI / 2
      effect.update t, layer

      deviation = grid.height / 2 / Math.sqrt(2 * 0.5**2)
      top_row    = 0.5 + deviation
      bottom_row = 0.5 - deviation

      assert_in_epsilon top_row, layer[1, 0].q
      assert_in_epsilon top_row, layer[1, 1].q
      assert_in_epsilon top_row, layer[1, 2].q

      assert_in_epsilon bottom_row, layer[0, 0].q
      assert_in_epsilon bottom_row, layer[0, 1].q
      assert_in_epsilon bottom_row, layer[0, 2].q
    end
  end
end
