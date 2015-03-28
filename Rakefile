require 'bundler/gem_tasks'
require 'rspec/core'
require 'rspec/core/rake_task'

task default: :spec
task test: :spec

desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new(:spec)

desc 'Run application locally from source'
task :run, [:arg1, :arg2] do |_t, _args|
  require 'rubygems'
  require 'bundler'
  Bundler.setup
  require 'london-bike-hire-cli'

  LondonBikeHireCli::Application.new.run
end
