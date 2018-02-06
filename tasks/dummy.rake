# frozen_string_literal: true

dummy_root_path = File.expand_path('../../spec/support/dummy', __FILE__)
dummies = Dir["#{dummy_root_path}/*"].map { |path| File.basename(path) }

def system!(*args)
  system(*args) || abort("\n== Command #{args} failed ==")
end

namespace :dummy do
  desc 'Run all tests for all dummies'
  task rspec: dummies.map { |dummy| "dummy:rspec:#{dummy}" }

  namespace :rspec do
    dummies.each do |dummy|
      desc "Run all specs for #{dummy} dummy application"
      task dummy do
        chdir File.join(dummy_root_path, dummy) do
          system! 'bin/rspec'
        end
      end
    end
  end

  namespace :spring do
    desc 'Stop springs for all dummies'
    task :stop do
      dummies.each do |dummy|
        chdir File.join(dummy_root_path, dummy) do
          system! 'bin/spring', 'stop'
        end
      end
    end
  end

  desc 'Install dependencies for all dummies'
  task :dep do
    dummies.each do |dummy|
      chdir File.join(dummy_root_path, dummy) do
        system! 'bin/bundle', 'update'
        system! 'bin/bundle', 'install'
        system! 'bin/yarn', 'install'
      end
    end
  end
end
