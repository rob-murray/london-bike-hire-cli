require 'bundler/gem_tasks'
require 'rspec/core'
require 'rspec/core/rake_task'

task default: :spec

desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new(:spec)

desc 'Run application locally from source'
task :run do
  require 'rubygems'
  require 'bundler'
  Bundler.setup
  require 'barclays-bike-london-cli'

  BarclaysBikeCli::Application.new.run
end
