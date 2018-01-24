$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'maac/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'maac'
  s.version     = Maac::VERSION
  s.authors     = ['Igor M Osipov']
  s.email       = ['osipov.igor.amigo@gmail.com']
  s.homepage    = 'https://github.com/igorakaamigo/maac'
  s.summary     = %q{Bootstrap confirmation modal for data-confirm'ed links @ Rails 5 projects}
  s.description = %q{This gem allows you to replace standard confirm() call for data-confirm'ed page elements, with a bootstrap modal.}
  s.license     = 'MIT'
  s.files       = Dir['MIT-LICENSE', 'README.md', 'lib/maac.rb', 'vendor/assets/javascripts/maac.js']

  s.add_dependency 'rails', '~> 5.1.4'

  s.add_development_dependency 'sqlite3'

  s.add_development_dependency 'rspec-rails'

  s.add_development_dependency 'capybara'

  s.add_development_dependency 'factory_bot_rails'

  s.add_development_dependency 'coffee-script'

  s.add_development_dependency 'poltergeist'
end
