# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tennis/version'

Gem::Specification.new do |spec|
  spec.name          = "tennis"
  spec.version       = Tennis::VERSION
  spec.authors       = ["nnattawat"]
  spec.email         = ["armmer1@gmail.com"]

  spec.summary       = %q{Tennis game}
  spec.description   = %q{Simple tennis game with not sets or tie break}
  spec.homepage      = "https://github.com/nnattawat/tennis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end
