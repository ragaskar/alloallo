# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alloallo/version"

Gem::Specification.new do |s|
  s.name        = "alloallo"
  s.version     = AlloAllo::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rajan Agaskar"]
  s.email       = ["ragaskar@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A gem to parse the output of Allocations}
  s.description = %q{If that made any sense to you, you might like this.}

  s.add_development_dependency "rspec", "~>2.5.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
