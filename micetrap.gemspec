# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "micetrap/version"

Gem::Specification.new do |s|
  s.name        = "micetrap"
  s.version     = Micetrap::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josep M. Bach"]
  s.email       = ["josep.m.bach@gmail.com"]
  s.homepage    = "http://github.com/txus/micetrap"
  s.summary     = %q{Catch evil hackers on the fly by placing open-port traps emulating fake vulnerable services!}
  s.description = %q{Catch evil hackers on the fly by placing open-port traps emulating fake vulnerable services!}

  s.rubyforge_project = "micetrap"

  s.add_runtime_dependency 'trollop'
  s.default_executable = "micetrap"

  s.add_development_dependency 'bundler', '~> 1.0.7'
  s.add_development_dependency 'rspec',   '~> 2.3.0'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
