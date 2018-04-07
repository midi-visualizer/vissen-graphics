require 'test_helper'

class TestGraphicsEffectTarget
  include Vissen::Graphics::Effect
end

describe Vissen::Graphics::Effect do
  subject { TestGraphicsEffectTarget }

  let(:context) { Vissen::Output::Stack.new 2, 3, 1, [[]] }
  let(:grid)    { Vissen::Output::VixelGrid.new context }
  let(:params)  { { test: true } }
  let(:effect)  { subject.new context, params }

  describe '.new' do
    it 'accepts a context' do
      assert_silent { subject.new context }
    end

    it 'raises a TypeError if not given a context' do
      assert_raises(TypeError) { subject.new Object.new }
    end

    it 'accepts an initial set of parameters' do
      assert effect.params[:test]
    end
  end

  describe '#configure' do
    it 'allows the parameters to be changed' do
      effect.configure test: false

      refute effect.params[:test]
    end
  end

  describe '#update' do
    it 'raises an error if update is not implemented' do
      assert_raises(NotImplementedError) { effect.update 0, nil }
    end
  end
end
