# encoding: UTF-8

if (RUBY_PLATFORM == 'java')
  require 'rhino'
else
  require 'v8'
end
require 'commonjs'
require 'escodegen'

require 'esprima/parser'
require 'esprima/ast'

# hack for inconsistency between Ruby 1.8 and 1.9
Enumerator = Enumerable::Enumerator unless defined?(Enumerator)

module Esprima
  def self.load_path
    @load_path ||= File.expand_path(File.join(File.dirname(__FILE__), "../vendor"))
  end

  def self.new_environment
    if (RUBY_PLATFORM == 'java')
      context = Rhino::Context.new
    else
      context = V8::Context.new
    end
    env = CommonJS::Environment.new(context, :path => Esprima.load_path)
    env.require("esprima")
  end
end
