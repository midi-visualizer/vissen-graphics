# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Modulator::Sum do
  subject { Vissen::Graphics::Modulator::Sum }

  let(:sum) { subject.new }

  it 'produces a sum' do
    a = rand
    b = rand
    sum.set :input_a, a
    sum.set :input_b, b
    sum.tainted?

    assert_in_epsilon a + b, sum.value
  end
end
