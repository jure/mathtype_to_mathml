# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mathtype_to_mathml/version'

Gem::Specification.new do |spec|
  spec.name          = "mathtype_to_mathml"
  spec.version       = MathTypeToMathML::VERSION
  spec.authors       = ["Jure Triglav"]
  spec.email         = ["juretriglav@gmail.com"]
  spec.summary       = %q{Converts from a binary MathType format (MTEF) to MathML.}
  spec.description   = %q{This gem can be used to convert MathType equations from a binary format (e.g. embedded in Word documents) to an open MathML representation. It achieves that in several stages, first using the "mathtype" gem to convert from a binary to an XML form of MTEF, and second, using XSLTs to convert XML to MathML.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "equivalent-xml", "~> 0.6"

  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "mathtype", "~> 0.1.0"
end
