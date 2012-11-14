# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'handy_sort/version'

Gem::Specification.new do |gem|
  gem.name          = "handy_sort"
  gem.version       = HandySort::VERSION
  gem.authors       = ["moro"]
  gem.email         = ["moronatural@gmail.com"]
  gem.description   = %q{Ultra simple manual sort key handling for ActiveRecord models.}
  gem.summary       = %q{Ultra simple manual sort key handling for ActiveRecord models.}
  gem.homepage      = "https://github.com/moro/handy_sort"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activerecord', '>= 3.2'
end
