require 'rubygems'
require 'bundler'
Bundler.setup
require 'barclays_bike_cli'

BarclaysBikeCli::Application.new.run
