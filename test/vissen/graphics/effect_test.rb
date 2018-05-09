# frozen_string_literal: true

require 'test_helper'

class TestGraphicsEffectTarget
  include Vissen::Graphics::Effect
end

describe Vissen::Graphics::Effect do
  subject { TestGraphicsEffectTarget }

  let(:context) { Vissen::Output::Context::Grid.new 2, 3 }
  let(:grid)    { Vissen::Output::VixelBuffer.new context }
  let(:effect)  { subject.new context }

  describe '.new' do
    it 'accepts a context' do
      assert_equal context, effect.context
    end

    it 'raises a TypeError if not given a context' do
      assert_raises(TypeError) { subject.new Object.new }
    end
  end

  describe '#update' do
    it 'raises an error if update is not implemented' do
      assert_raises(NotImplementedError) { effect.update 0 }
    end
  end
end
