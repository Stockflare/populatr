# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'populatr/version'

Gem::Specification.new do |spec|
  spec.name          = "populatr"
  spec.version       = Populatr::VERSION
  spec.authors       = ["Stockflare"]
  spec.email         = ["info@stockflare.com"]
  spec.summary       = %q{Integrates with AWS Cloudformation to populate Etcd keys}
  spec.description   = %q{Integrates with AWS Cloudformation to populate Etcd keys. Works directly as a service within CoreOS}
  spec.post_install_message = "Ensure to use the FQDN with the --listen property"
  spec.homepage      = "http://davidkelley.me"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency 'rspec', '~> 3.1', '>= 3.1.0'
  spec.add_development_dependency "rake", '~> 10.4', '>= 10.4.2'
  spec.add_development_dependency "webmock", '~> 1.21', '>= 1.21.0'

  spec.add_dependency "thor", '~> 0.19.1', '>= 0.19.1'
  spec.add_dependency "activesupport", '~> 4.2', '>= 4.2.1'
  spec.add_dependency "aws-sdk", '~> 2.0', '>= 2.0.39'
  spec.add_dependency "etcd", '~> 0.3', '>= 0.3.0'



end
