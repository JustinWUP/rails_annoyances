# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails_annoyances/version"

Gem::Specification.new do |s|
  s.name        = "rails_annoyances"
  s.version     = RailsAnnoyances::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin Bean"]
  s.email       = ["justin.r.bean@gmail.com"]
  s.homepage    = "http://github.com/justinwup"
  s.summary     = %q{Rails Annoyances Fixer}
  s.description = %q{This fixes a bunch of annoying shit about Rails 4.}
  
  s.add_development_dependency "rspec"

  s.rubyforge_project = "rails_annoyances"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end