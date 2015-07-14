# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'populatr/version'

Gem::Specification.new do |spec|
  spec.name          = "populatr"
  spec.version       = Populatr::VERSION
  spec.authors       = ["Stockflare"]
  spec.email         = ["info@stockflare.com"]
  spec.summary       = %q{Integrates with Etcd to populate keys}
  spec.description   = %q{Integrates with Etcd to populate keys. Works directly within CoreOS}
  spec.post_install_message = "Ensure to use both the --key and --value keys"
  spec.homepage      = "http://stockflare.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ambassadr"



end
