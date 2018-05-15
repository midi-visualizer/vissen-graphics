# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Engine do
  subject { Vissen::Graphics::Engine }

  it 'works as expected' do
    context = Vissen::Output::Context::Grid.new 2, 3
    stack   = Vissen::Output::VixelStack.new context, 1

    mod_r = Vissen::Graphics::Modulator::Ramp.new
    mod_a = Vissen::Graphics::Modulator::Bias.new setup: {
      input: mod_r,
      amplitude: 0.2
    }
    mod_b = Vissen::Graphics::Modulator::Bias.new setup: {
      offset: 0.5,
      amplitude: 2.0,
      input: 0.0
    }

    effect = Vissen::Graphics::Effect::Gradient.new setup: {
      mean: mod_a,
      spread: mod_b
    }

    mixer = Vissen::Graphics::Mixer.new stack.layers[0], setup: {
      effect: effect,
      mix_i: mod_r,
      mix_p: 1.0
    }

    engine = Vissen::Graphics::Engine.new [mixer]

    mod_b.bind(:input, mod_r)
    mod_r.bind(:t, engine.time)

    engine.render(0.5)
    p stack.layers[0]
  end
end
