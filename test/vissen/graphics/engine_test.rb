# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Engine do
  subject { Vissen::Graphics::Engine }

  let(:context) { Vissen::Output::Context::Grid.new 2, 3 }
  let(:stack)   { Vissen::Output::VixelStack.new context, 1 }
  let(:mod_r)   { Vissen::Graphics::Modulator::Ramp.new }
  let(:effect) do
    Vissen::Graphics::Effect::Gradient.new setup: { angle: mod_r }
  end
  let(:mixer) do
    Vissen::Graphics::Mixer::Absolute.new stack.layers[0], setup: {
      effect: effect,
      p: 1.0
    }
  end
  let(:engine) { Vissen::Graphics::Engine.new [mixer] }

  describe '.new' do
    it 'binds time automatically' do
      engine.render 0.5
      assert_equal 0.5, mod_r.params.t

      engine.render 1.5
      assert_equal 1.5, mod_r.params.t
    end
  end

  describe '#render' do
    it 'renders the mixers' do
      engine.render 0.0
      values_before = stack.layers[0].elements.map(&:p)

      engine.render 0.1
      values_after = stack.layers[0].elements.map(&:p)

      refute_equal values_before, values_after
    end
  end
end
