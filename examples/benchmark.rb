# frozen_string_literal: true

require 'benchmark'

require 'vissen/graphics'
require 'vissen/output'

# rubocop:disable Style/MixinUsage
include Vissen
# rubocop:enable Style/MixinUsage

N = 1_000

context = Output::Context::Grid.new 15, 15
stack   = Output::VixelStack.new context, 1
mod_r = Graphics::Modulator::Ramp.new
mod_a = Graphics::Modulator::Bias.new setup: {
  input: mod_r,
  amplitude: 0.2
}

mod_b = Graphics::Modulator::Bias.new setup: {
  offset: 0.5,
  amplitude: 2.0,
  input: mod_a
}

effect = Graphics::Effect::Gradient.new setup: {
  mean: mod_a,
  spread: mod_b,
  angle: mod_r
}

mixer = Graphics::Mixer.new stack.layers[0], setup: {
  effect: effect,
  mix_i: mod_r,
  mix_p: 1.0
}

engine = Graphics::Engine.new [mixer]

puts 'Benchmark results:'

res =
  Benchmark.bm(10) do |x|
    x.report('static') do
      N.times { engine.render(0) }
    end

    x.report('render') do
      N.times { engine.render(Time.now.to_f) }
    end
  end

puts
puts format('%.2f us per frame', res.last.utime * (1_000_000 / N))
puts format('%.0f frames per second', N / res.last.utime)
