# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'barclays_bike_cli/version'

Gem::Specification.new do |spec|
  spec.name          = 'barclays-bike-london-cli'
  spec.version       = BarclaysBikeCli::VERSION
  spec.authors       = ['Rob Murray']
  spec.email         = ['robmurray17@gmail.com']
  spec.summary       = %q(A command line interface to Barclays Bike API.)
  spec.description   = %q(Find information about London's Barclays Bike stations from command line interface.)
  spec.homepage      = 'https://github.com/rob-murray/barclays-bike-london-cli'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard', '~> 2.6'
  spec.add_development_dependency 'guard-rspec', '~> 4.3'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'coveralls', '~> 0.7'
  spec.add_development_dependency 'codeclimate-test-reporter'

  spec.add_dependency 'commander', '~> 4.2'
  spec.add_dependency 'nokogiri', '~> 1.6'
end
