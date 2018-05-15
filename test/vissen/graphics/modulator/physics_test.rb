# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Modulator::Physics do
  subject { Vissen::Graphics::Modulator::Physics }

  let(:physics) { subject.new }
  let(:physics_at) do
    lambda do |t|
      physics.set :t, t
      physics.tainted?
      physics.untaint!
      physics.value
    end
  end

  it 'supports constant position' do
    physics.set :position, 0.5
    assert_equal 0.5, physics_at.call(0.0)
    assert_equal 0.5, physics_at.call(1.0)
  end

  it 'supports constant velocity' do
    physics.set :velocity, 0.5
    assert_equal 0.0, physics_at.call(0.0)
    assert_equal 0.5, physics_at.call(1.0)
    assert_equal 1.0, physics_at.call(2.0)
  end

  it 'supports constant acceleration' do
    physics.set :acceleration, 0.5
    assert_equal 0.0, physics_at.call(0.0)
    assert_equal 0.5, physics_at.call(1.0)
    assert_equal 2.0, physics_at.call(2.0)
  end

  it 'supports a time offset' do
    physics.set :position, 0.5
    physics.set :velocity, 0.5
    physics.set :acceleration, 0.5
    physics.set :offset, 0.5

    assert_equal 0.5, physics_at.call(0.5)
    assert_equal 0.875, physics_at.call(1.0)
  end
end
