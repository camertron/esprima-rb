# encoding: UTF-8

module Esprima
  class AST
    include Enumerable

    attr_reader :tree, :esprima

    def initialize(tree, environment = nil)
      @esprima = @environment || Esprima.new_environment
      @tree = tree
    end

    def to_ecma(options = {})
      Escodegen::Generator.new.generate(@tree, options)
    end

    def is_list?
      @tree.is_a?(Array)
    end

    def is_hash?
      @tree.is_a?(Hash)
    end

    def [](key)
      @tree[key]
    end

    def each
      if block_given?
        each_node { |node| yield Esprima::AST.new(node, @esprima) }
      else
        nodes = []
        each_node { |node| nodes << Esprima::AST.new(node, @esprima) }
        nodes.to_enum
      end
    end

    protected

    def each_node
      if tree.is_a?(Array)
        tree.each do |t|
          yield t if yieldable?(t)
          Esprima::AST.new(t, @esprima).each_node { |sub_t| yield sub_t if yieldable?(sub_t) }
        end
      elsif tree.is_a?(Hash)
        tree.each_pair do |_, t|
          yield t if yieldable?(t)
          Esprima::AST.new(t, @esprima).each_node { |sub_t| yield sub_t if yieldable?(sub_t) }
        end
      end
    end

    def yieldable?(obj)
      obj.is_a?(Hash) || obj.is_a?(Array)
    end
  end
end