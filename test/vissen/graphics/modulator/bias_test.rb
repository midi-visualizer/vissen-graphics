# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Modulator::Bias do
  subject { Vissen::Graphics::Modulator::Bias }

  let(:bias) { subject.new }

  it 'offsets and scales' do
    amplitude = rand
    input     = rand
    offset    = rand

    bias.set :amplitude, amplitude
    bias.set :input, input
    bias.set :offset, offset
    bias.tainted?

    assert_in_epsilon input * amplitude + offset, bias.value
  end
end
