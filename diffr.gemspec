# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "diffr/version"

Gem::Specification.new do |s|
  s.name        = "diffr"
  s.version     = Diffr::VERSION
  s.authors     = ["Matt Sears"]
  s.email       = ["matt@mattsears.com"]
  s.homepage    = "http://www.mattsears.com"
  s.summary     = %q{A simple diff utility written in Ruby}
  s.description = %q{A simple utility that returns the differences between two objects}

  s.rubyforge_project = "diffr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "simplecov"
  s.add_development_dependency "minitest"
  s.add_development_dependency "yard"
  s.add_development_dependency "rdiscount"
  # s.add_runtime_dependency "rest-client"
end
