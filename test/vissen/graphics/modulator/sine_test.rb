# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Modulator::Sine do
  subject { Vissen::Graphics::Modulator::Sine }

  let(:sine) { subject.new setup: { frequency: 0.25 } }
  let(:sine_at) do
    lambda do |t|
      sine.set :t, t
      sine.tainted?
      sine.untaint!
      sine.value
    end
  end

  it 'produces a sine wave' do
    assert_in_epsilon 0.5, sine_at.call(0.0)
    assert_in_epsilon 1.0, sine_at.call(1.0)
    assert_in_epsilon 0.5, sine_at.call(2.0)
    assert_in_epsilon 0.0, sine_at.call(3.0)
  end

  it 'accepts a phase' do
    sine.set :phase, 0.5
    assert_in_epsilon 0.0, sine_at.call(1.0)
  end
end
