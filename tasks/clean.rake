# frozen_string_literal: true

require 'fileutils'

desc 'remove all temporary files and results of a previoous bulld'
task :clean do
  FileUtils.remove_dir(File.expand_path('../../pkg', __FILE__), true)
  FileUtils.remove_dir(File.expand_path('../../tmp', __FILE__), true)
end
