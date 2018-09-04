# frozen_string_literal: true

lib = File.expand_path('lib', __dir__).freeze
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib

require 'yardstick/version'

Gem::Specification.new do |spec|
  spec.name     = 'yardstick'
  spec.version  = Yardstick::VERSION
  spec.license  = 'MIT'
  spec.homepage = 'https://github.com/dkubb/yardstick'
  spec.summary  = 'YARD documentation coverage measurement tool'

  spec.authors = ['Dan Kubb']
  spec.email   = %w[dan.kubb@gmail.com]

  spec.description = <<-DESCRIPTION.split.join ' '
    yard-cov is YARD documentation coverage measurement tool. It will measure
    the source and provide feedback on what is missing from the documentation
    and what can be improved.
  DESCRIPTION

  spec.require_paths    = %w[lib]
  spec.files            = `git ls-files`.split("\n")
  spec.test_files       = `git ls-files -- spec/{unit,integration}`.split("\n")
  spec.extra_rdoc_files = %w[LICENSE README.md]
  spec.executables      = %w[yardstick]

  spec.add_runtime_dependency 'abstract_type', '~> 0.0'
  spec.add_runtime_dependency 'adamantium',    '~> 0.2'
  spec.add_runtime_dependency 'concord',       '~> 0.1'
  spec.add_runtime_dependency 'ice_nine',      '~> 0.11'
  spec.add_runtime_dependency 'yard',          '~> 0.8', '>= 0.8.7.2'

  spec.add_development_dependency 'bundler', '~> 1.6', '>= 1.6.1'
end
