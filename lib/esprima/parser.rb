# encoding: UTF-8

module Esprima
  class Parser
    def initialize
      @context = V8::Context.new
      @env = CommonJS::Environment.new(@context, :path => Esprima.load_path)
      @esprima = @env.require("esprima")
    end

    def parse(code)
      to_ruby(@esprima.parse(code))
    end

    def parse_file(file)
      parse(read_file(file))
    end

    protected

    # mostly exists for mocking purposes
    def read_file(file)
      File.read(file)
    end

    def to_ruby(obj)
      if obj.is_a?(V8::Array)
        obj.map { |val| to_ruby(val) }
      elsif obj.is_a?(V8::Object)
        obj.inject({}) { |ret, (key, val)| ret[key.to_sym] = to_ruby(val); ret }
      else
        obj
      end
    end
  end
end