# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/jinshuju/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-jinshuju'
  spec.version       = OmniAuth::Jinshuju::VERSION
  spec.authors       = ['Michael Chen']
  spec.email         = ['michael.chen@admaster.com.cn']

  spec.summary       = %q{Offical Jinshuju OAuth2 strategy for OmniAuth}
  spec.description   = %q{Offical Jinshuju OAuth2 strategy for OmniAuth}
  spec.homepage      = 'https://github.com/jinshuju/omniauth-jinshuju'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.3.1'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
end
