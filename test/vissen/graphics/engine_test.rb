# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Engine do
  subject { Vissen::Graphics::Engine }

  it 'works as expected' do
    context = Vissen::Output::Context::Grid.new 2, 3
    stack   = Vissen::Output::VixelStack.new context, 1
    
    mod_r = Vissen::Graphics::Modulator::Ramp.new
    mod_a = Vissen::Graphics::Modulator::Bias.new  input: mod_r,
                                               amplitude: 0.2
    mod_b = Vissen::Graphics::Modulator::Bias.new offset: 0.5,
                                               amplitude: 2.0,
                                                   input: mod_a

    effect = Vissen::Graphics::Effect::Gradient.new context,
                                                    mean: mod_a,
                                                  spread: mod_b

    mixer = Vissen::Graphics::Mixer.new effect, stack.layers[0],
                                        mix_i: mod_r,
                                        mix_p: 1.0
                                        
    engine = Vissen::Graphics::Engine.new [mixer]
    
    engine.render(0.5)
    p stack.layers[0]
  end
end
