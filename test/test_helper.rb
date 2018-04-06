$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start 'test_frameworks'

require 'vissen/graphics'
require 'minitest/autorun'
