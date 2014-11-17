# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_annoyances/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_annoyances"
  spec.version       = RailsAnnoyances::VERSION
  spec.authors       = ["Justin Bean"]
  spec.email         = ["justin.r.bean@gmail.com"]
  spec.summary       = %q{Rails Annoyances Fixer}
  spec.description   = %q{This fixes a bunch of annoying shit about Rails 4.}
  spec.homepage      = "http://justinwup.github.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").delete('gemspec')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end