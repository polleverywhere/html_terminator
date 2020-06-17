# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'html_terminator/version'

Gem::Specification.new do |spec|
  spec.name          = "html_terminator"
  spec.version       = HtmlTerminator::VERSION
  spec.authors       = ["Steel Fu", "Matt Diebolt"]
  spec.email         = ["steel@polleverywhere.com", "matt@polleverywhere.com"]
  spec.description   = %q{Terminate Active Records fields of html}
  spec.summary       = %q{Terminate Active Records fields of html}
  spec.homepage      = "https://github.com/polleverywhere/html_terminator/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "sanitize", "~> 5.2.1"
end
