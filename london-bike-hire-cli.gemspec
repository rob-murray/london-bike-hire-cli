# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'london_bike_hire_cli/version'

Gem::Specification.new do |spec|
  spec.name          = 'london-bike-hire-cli'
  spec.version       = LondonBikeHireCli::VERSION
  spec.authors       = ['Rob Murray']
  spec.email         = ['robmurray17@gmail.com']
  spec.summary       = "A command line interface to London's Bike Hire API."
  spec.description   = "Find information about London's Bike Hire stations from command line interface."
  spec.homepage      = 'https://github.com/rob-murray/london-bike-hire-cli'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.0.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'

  spec.add_dependency 'commander', '~> 4.2'
  spec.add_dependency 'nokogiri', '~> 1.6'
  spec.add_dependency 'kdtree', '~> 0.3'
  spec.add_dependency 'geocoder', '~> 1.2'
end
