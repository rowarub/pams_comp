# -*- encoding: utf-8 -*-
# stub: chart-js-rails 0.1.6 ruby lib

Gem::Specification.new do |s|
  s.name = "chart-js-rails"
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Keith Walsh"]
  s.date = "2018-06-10"
  s.description = "Chart.js for use in Rails asset pipeline"
  s.email = ["walsh1kt@gmail.com"]
  s.homepage = ""
  s.rubygems_version = "2.5.1"
  s.summary = "Create HTML5 charts"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, ["> 3.1"])
    else
      s.add_dependency(%q<railties>, ["> 3.1"])
    end
  else
    s.add_dependency(%q<railties>, ["> 3.1"])
  end
end
