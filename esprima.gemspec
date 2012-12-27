$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'esprima/version'

Gem::Specification.new do |s|
  s.name     = "esprima"
  s.version  = Esprima::VERSION
  s.authors  = ["Cameron Dutro", "Ariya Hidayat"]
  s.email    = ["cdutro@twitter.com", "ariya.hidayat@gmail.com"]
  s.homepage = "http://esprima.org"

  s.description = s.summary = "Ruby wrapper around the Esprima static code analyzer for JavaScript."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'execjs', '~> 1.4.0'
  s.add_dependency 'commonjs', '~> 0.2.6'
  s.add_dependency 'escodegen', '~> 1.2.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.11.0'
  s.add_development_dependency 'rr',    '~> 1.0.4'

  s.require_path = 'lib'
  s.files = Dir["{lib,spec,vendor}/**/*", "Gemfile", "History.txt", "LICENSE", "NOTICE", "README.md", "Rakefile", "esprima.gemspec"]
end
