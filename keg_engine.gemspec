$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "keg_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "keg_engine"
  s.version     = KegEngine::VERSION
  s.authors     = ["Kristaps Erglis"]
  s.email       = ["kristaps.erglis@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of KegEngine."
  s.description = "Description of KegEngine."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 3.2.8'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'haml-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'twitter-bootstrap-rails'
  s.add_dependency 'devise'
  s.add_dependency 'omniauth-facebook'
  s.add_dependency 'app_config'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'rspec-rails'
  s.add_dependency 'factory_girl_rails'
  s.add_dependency 'simple_form'
  s.add_dependency 'state_machine'
  s.add_dependency 'meta_search'
  s.add_dependency 'will_paginate'
  s.add_dependency 'inherited_resources'

  s.add_development_dependency 'thin'

end
