#!/usr/bin/env rake

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path('../spec/dummy/Rakefile', __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each { |f| load f }

require 'rspec/core'
require 'rspec/core/rake_task'

desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new(:spec => 'app:db:test:prepare')

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Maac'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Compile vendor scripts'
task 'vendor:compile' do
  require 'maac/version'
  require 'coffee-script'
  require 'fileutils'

  FileUtils.mkpath('vendor/assets/javascripts')
  File.open('vendor/assets/javascripts/maac.js', 'w') do |f|
    source = File.new('lib/maac.coffee').read
    version = Maac::VERSION
    f << CoffeeScript::compile(source.gsub(/{VERSION}/, "v#{version}").gsub(/{DATE}/, DateTime.now.to_s))
  end
end

desc 'Clean vendor scripts'
task 'vendor:clean' do
  FileUtils.remove_dir('vendor', true)
end

desc 'Compile assets & rspec'
task test: [:'vendor:clean', :'vendor:compile', :spec]

task :default => :test
