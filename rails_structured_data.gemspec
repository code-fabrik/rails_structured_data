# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_structured_data/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_structured_data"
  spec.version       = RailsStructuredData::VERSION
  spec.authors       = ["Lukas_Skywalker"]
  spec.email         = ["lukas.diener@hotmail.com"]

  spec.summary       = "Easily embed structured data in your website"
  spec.description   = "Helpers for creating and embedding schema.org structured data for search engine optimization"
  spec.homepage      = "https://code-fabrik.ch"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
