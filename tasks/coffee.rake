# frozen_string_literal: true

require 'maac/version'
require 'fileutils'
require 'coffee-script'

namespace :coffee do
  desc 'Compile coffeescript'
  task :compile do
    target_path = File.expand_path('../../app/assets/javascripts', __FILE__)
    source_path = File.expand_path('../../src', __FILE__)
    version     = Maac::VERSION
    now         = Time.now

    Dir["#{source_path}/**/*.coffee"].each do |source_file|
      target_file = File.join(target_path, source_file.sub(source_path, '')).sub(/\.coffee$/, '.js')

      FileUtils.mkpath File.expand_path('../', target_file)
      File.open(target_file, 'w') do |f|
        source = File.new(source_file).read.gsub(/{VERSION}/, version).gsub(/{DATE}/, now.to_s)
        f << CoffeeScript.compile(source)
      end
    end

    Dir["#{source_path}/**/*.coffee.erb"].each do |source_file|
      target_file = File.join(target_path, source_file.sub(source_path, '')).sub(/\.coffee.erb$/, '.js.erb')
      FileUtils.mkpath File.expand_path('../', target_file)
      File.open(target_file, 'w') do |f|
        source = File.new(source_file).read.gsub(/{VERSION}/, version).gsub(/{DATE}/, now.to_s)

        i       = 1
        items   = []
        stub    = lambda { "\"__STUB__#{i}__\"" }
        pattern = /<%=.*?%>/m
        until source[pattern].nil?
          items << [stub.call, source[pattern]]
          source[pattern] = stub.call
          i = i + 1
        end

        compiled = CoffeeScript.compile(source)
        items.each do |item|
          compiled.gsub!(item.first, item.last)
        end
        f << compiled
      end
    end
  end

  desc 'Remove all built files'
  task :clean do
    FileUtils.remove_dir File.expand_path('../../app', __FILE__)
  end
end
