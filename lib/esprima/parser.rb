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
      if js_type_of?(obj, :array)
        obj.map { |val| to_ruby_hash(val) }
      elsif js_type_of?(obj, :object)
        obj.inject({}) { |ret, (key, val)| ret[key.to_sym] = to_ruby_hash(val); ret }
      elsif js_type_of?(obj, :consstring)
        obj.toString
      else
        obj
      end
    end

    protected

    def js_type_of?(obj, type_sym)
      obj.class.to_s.split("::").last.downcase.include?(type_sym.to_s)
    end
  end
end
