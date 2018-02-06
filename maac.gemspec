# frozen_string_literal: true
$:.push File.expand_path('../lib', __FILE__)

require 'maac/version'

Gem::Specification.new do |s|
  s.name        = 'maac'
  s.version     = Maac::VERSION
  s.authors     = ['Igor M Osipov']
  s.email       = ['osipov.igor.amigo@gmail.com']
  s.homepage    = 'https://github.com/igorakaamigo/maac'
  s.summary     = 'Configurable confirmation modal (Bootstrap or custom markup) for data-confirm\'ed links @ Rails 5 projects'
  s.description = 'This gem allows you to replace standard confirm() call for data-confirm\'ed page elements, with a nice styled modal.'
  s.license     = 'MIT'
  s.files       = Dir['MIT-LICENSE', 'README.md', 'lib/**/*.rb', 'app/**/*.js', 'app/**/*.js.erb', 'tpl/**/*.html']
end
