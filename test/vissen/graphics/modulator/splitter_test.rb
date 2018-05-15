# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Modulator::Splitter do
  subject { Vissen::Graphics::Modulator::Splitter }

  let(:splitter) { subject.new }

  it 'exposes the components of a vec' do
    a = rand
    b = rand
    splitter.set :input_a, a
    splitter.set :input_b, b
    splitter.tainted?

    assert_equal [a, b], splitter.value
  end
end
