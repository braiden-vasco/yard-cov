# frozen_string_literal: true

lib = File.expand_path('lib', __dir__).freeze
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib

require 'yardstick/version'

Gem::Specification.new do |gem|
  gem.name     = 'yardstick'
  gem.version  = Yardstick::VERSION
  gem.license  = 'MIT'
  gem.homepage = 'https://github.com/dkubb/yardstick'
  gem.summary  = 'A tool for verifying YARD documentation coverage'

  gem.authors = ['Dan Kubb']
  gem.email   = %w[dan.kubb@gmail.com]

  gem.description = 'Measure YARD documentation coverage'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE README.md]
  gem.executables      = %w[yardstick]

  gem.add_runtime_dependency 'abstract_type', '~> 0.0'
  gem.add_runtime_dependency 'adamantium',    '~> 0.2'
  gem.add_runtime_dependency 'concord',       '~> 0.1'
  gem.add_runtime_dependency 'ice_nine',      '~> 0.11'
  gem.add_runtime_dependency 'yard',          '~> 0.8', '>= 0.8.7.2'

  gem.add_development_dependency 'bundler', '~> 1.6', '>= 1.6.1'
end
