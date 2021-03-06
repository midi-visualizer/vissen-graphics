# frozen_string_literal: true

require 'forwardable'

require 'vissen/graphics/version'

require 'vissen/output'
require 'vissen/parameterized'

require 'vissen/graphics/modulator'
require 'vissen/graphics/modulator/base'
require 'vissen/graphics/modulator/bias'
require 'vissen/graphics/modulator/ramp'
require 'vissen/graphics/modulator/physics'
require 'vissen/graphics/modulator/sine'
require 'vissen/graphics/modulator/splitter'
require 'vissen/graphics/modulator/sum'

require 'vissen/graphics/effect'
require 'vissen/graphics/effect/output'
require 'vissen/graphics/effect/base'
require 'vissen/graphics/effect/gradient'
require 'vissen/graphics/effect/vignette'
require 'vissen/graphics/effect/point'

require 'vissen/graphics/mixer'
require 'vissen/graphics/mixer/output'
require 'vissen/graphics/mixer/base'
require 'vissen/graphics/mixer/absolute'
require 'vissen/graphics/mixer/additive'
require 'vissen/graphics/mixer/multiplicative'

require 'vissen/graphics/engine'

module Vissen
  # Graphics
  #
  #
  module Graphics
  end
end
