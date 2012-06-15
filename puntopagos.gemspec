# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "puntopagos/version"

Gem::Specification.new do |s|
  s.name        = 'puntopagos'
  s.version     = PuntoPagos::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ignacio Mella", "Gert Findel"]
  s.email       = ["imella@acid.cl"]
  s.homepage    = %q{https://github.com/acidcl/puntopagos-ruby}
  s.summary     = %q{Ruby wrapper for PuntoPagos Payment API}
  s.description = %q{Ruby wrapper for PuntoPagos Payment API}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "rest-client"
  
  
end
