# encoding: UTF-8

require 'v8'
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
    context = V8::Context.new
    env = CommonJS::Environment.new(context, :path => Esprima.load_path)
    env.require("esprima")
  end
end
