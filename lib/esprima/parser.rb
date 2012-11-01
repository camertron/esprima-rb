# encoding: UTF-8

module Esprima
  class Parser
    def initialize
      @esprima = Esprima.new_environment
    end

    def parse(code)
      Esprima::AST.new(to_ruby_hash(@esprima.parse(code)), @esprima)
    end

    def parse_file(file)
      parse(read_file(file))
    end

    protected

    # mostly exists for mocking purposes
    def read_file(file)
      File.read(file)
    end

    def to_ruby_hash(obj)
      if obj.is_a?(V8::Array)
        obj.map { |val| to_ruby_hash(val) }
      elsif obj.is_a?(V8::Object)
        obj.inject({}) { |ret, (key, val)| ret[key.to_sym] = to_ruby_hash(val); ret }
      else
        obj
      end
    end
  end
end