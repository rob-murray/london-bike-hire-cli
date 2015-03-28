require 'rubygems'
require 'bundler'
Bundler.setup
require 'london_bike_hire_cli'

LondonBikeHireCli::Application.new.run
