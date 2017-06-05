lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/gometalinter/version'

Gem::Specification.new do |spec|
  spec.name = 'pronto-gometalinter'
  spec.version = Pronto::gometalinterVersion::VERSION
  spec.authors = ['Achmad Gozali']
  spec.email = ['gozali@gmail.com']

  spec.summary = 'Pronto runner for golang code linter'
  spec.homepage = 'https://github.com/gozali/pronto-gometalinter'
  spec.license = 'MIT'

  spec.files = Dir.glob('lib/**/*.rb') + ['pronto-gometalinter.gemspec', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency('pronto', '~> 0.8.0')
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 11.0'
end