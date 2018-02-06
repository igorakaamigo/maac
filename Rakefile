#!/usr/bin/env rake

Dir[File.join(File.dirname(__FILE__), '/tasks/**/*.rake')].each { |f| load f }

desc 'Compile and test'
task compile_and_test: %i[
  coffee:clean
  coffee:compile
  dummy:spring:stop
  dummy:rspec
]

task default: :compile_and_test
