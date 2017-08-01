# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pushwoosh/version'

Gem::Specification.new do |spec|
  spec.name          = 'pushwoosh'
  spec.version       = Pushwoosh::VERSION
  spec.authors       = ['Pedro Andrade', 'Vladimir Smyshlyaev']
  spec.email         = ['pedro.rjandrade@gmail.com', 'v@vforvova.ru']
  spec.description   = 'Pushwoosh wrapper to remote API'
  spec.summary       = 'Pushwoosh Remote API'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 2.3'
  spec.add_development_dependency 'pry', '~> 0.10.1'
end
