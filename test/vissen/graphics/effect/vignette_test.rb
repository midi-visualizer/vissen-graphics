# frozen_string_literal: true

require 'test_helper'

describe Vissen::Graphics::Effect::Vignette do
  subject { Vissen::Graphics::Effect::Vignette }

  let(:rows)     { 2 }
  let(:columns)  { 3 }
  let(:context)  { Vissen::Output::Context::Grid.new rows, columns }
  let(:grid)     { Vissen::Output::VixelBuffer.new context }
  let(:effect)   { subject.new context }
  let(:t)        { 0 }
end
