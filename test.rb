require 'rubygems'
require 'bundler'
Bundler.setup
require 'london_bike_hire_cli'
require 'byebug'

LondonBikeHireCli::Application.new.run
