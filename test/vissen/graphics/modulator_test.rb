# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Modulator do
  subject { Vissen::Graphics::Modulator }

  describe 'chaining' do
    it 'works as expected' do
      mod_a = subject::Bias.new setup: { input: 0.2 }
      mod_b = subject::Bias.new setup: {
        offset: 0.5,
        amplitude: 2.0,
        input: mod_a
      }
      mod_c = subject::Splitter.new setup: { input_a: mod_a, input_b: mod_b }

      mod_c.tainted?

      assert_equal 0.2, mod_a.value
      assert_equal 0.9, mod_b.value
      assert_equal [0.2, 0.9], mod_c.value
    end
  end
end
