# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Modulator::Ramp do
  subject { Vissen::Graphics::Modulator::Ramp }

  let(:ramp) { subject.new setup: { period: 2.0 } }
  let(:ramp_at) do
    lambda do |t|
      ramp.set :t, t
      ramp.tainted?
      ramp.untaint!
      ramp.value
    end
  end

  it 'produces a ramp' do
    assert_equal 0.0, ramp_at.call(0.0)
    assert_equal 0.5, ramp_at.call(1.0)
    assert_equal 1.0, ramp_at.call(2.0)
    assert_equal 1.5, ramp_at.call(3.0)
  end

  it 'accepts an offset' do
    ramp.set :offset, 0.5
    assert_equal 0.25, ramp_at.call(1.0)
  end
end
