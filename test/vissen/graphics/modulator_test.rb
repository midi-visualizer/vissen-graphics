# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Modulator do
  subject { Vissen::Graphics::Modulator }

  it 'works as expected' do
    mod_a = subject::Bias.new input: 0.2
    mod_b = subject::Bias.new offset: 0.5, amplitude: 2.0, input: mod_a
    mod_c = subject::Splitter.new input_a: mod_a, input_b: mod_b

    mod_a.update! 0.0
    mod_b.update! 0.0

    assert_equal 0.2, mod_a.value
    assert_equal 0.9, mod_b.value

    mod_b.untaint!
    refute mod_a.tainted?

    # Work out the update order given mod_b
    item = Linked::Item.new mod_c
    update_chain! item
    list = Linked::List.new.push(item.first_in_chain).freeze

    arr = list.map(&:value)

    assert_equal [mod_a, mod_b, mod_c], arr
    
    arr.each { |m| m.update! 0.0 }
    
    assert_equal [0.2, 0.9], mod_c.value
  end
end

def update_chain!(before_item)
  modulator = before_item.value
  matcher = ->(mod) { ->(e) { e.value == mod } }
  
  modulator.params.each do |_, param|
    next if param.constant?
    mod = param.modulator
    mod_matcher = matcher.call mod
    
    if before_item.after.find(&mod_matcher)
      raise RuntimeError, 'Cyclic parameter dependency'
    elsif before_item.before.find(&mod_matcher)
      next
    end

    item = Linked::Item.new mod
    before_item.prepend item
    update_chain! item
  end
end
