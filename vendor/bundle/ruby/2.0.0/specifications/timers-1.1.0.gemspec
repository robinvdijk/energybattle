# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "timers"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tony Arcieri"]
  s.date = "2013-01-19"
  s.description = "Pure Ruby one-shot and periodic timers"
  s.email = ["tony.arcieri@gmail.com"]
  s.homepage = "https://github.com/tarcieri/timers"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "Schedule procs to run after a certain time, or at periodic intervals, using any API that accepts a timeout"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end