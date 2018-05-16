# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Engine do
  subject { Vissen::Graphics::Engine }

  describe '.new' do
    it 'binds time automatically' do
      context = Vissen::Output::Context::Grid.new 2, 3
      stack   = Vissen::Output::VixelStack.new context, 1

      mod_r = Vissen::Graphics::Modulator::Ramp.new
      effect = Vissen::Graphics::Effect::Gradient.new setup: {
        angle: mod_r
      }

      mixer = Vissen::Graphics::Mixer::Absolute.new stack.layers[0], setup: {
        effect: effect,
        i: 0.0,
        p: 1.0
      }

      engine = Vissen::Graphics::Engine.new [mixer]

      engine.render 0.5
      assert_equal 0.5, mod_r.params.t

      engine.render 1.5
      assert_equal 1.5, mod_r.params.t
    end
  end
end
