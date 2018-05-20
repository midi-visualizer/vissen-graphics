
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vissen/graphics/version'

Gem::Specification.new do |spec|
  spec.name          = 'vissen-graphics'
  spec.version       = Vissen::Graphics::VERSION
  spec.authors       = ['Sebastian Lindberg']
  spec.email         = ['seb.lindberg@gmail.com']

  spec.summary       = 'Graphics library for the Vissen project.'
  spec.description   = 'This library implements the graphics context witch ' \
                       'can be setup as a fully parameterized animation and ' \
                       'effect renderer.'
  spec.homepage      = 'https://github.com/midi-visualizer/vissen-graphics'
  spec.license       = 'MIT'

  spec.metadata['yard.run'] = 'yri'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'vissen-output', '~> 0.7.0'
  spec.add_dependency 'vissen-parameterized', '~> 0.1.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.52'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'yard', '~> 0.9'
end
