# encoding: UTF-8

require "spec_helper"

EXPRESSION = "7 + 8"
AST_RESULT = [{
  :type => "ExpressionStatement",
  :expression => {
    :left => {
      :type => "Literal",
      :value => 7
    },
    :type => "BinaryExpression",
    :right => {
      :type => "Literal",
      :value => 8
    },
    :operator => "+"
  }
}]

AST_RESULT_LOC = [{
  :type => "ExpressionStatement",
  :expression => {
    :type => "BinaryExpression",
    :operator => "+",
    :left => {
      :type => "Literal",
      :value => 7,
      :loc => {
        :start => {:line => 1, :column => 0},
        :end => { :line => 1, :column => 1},
      }
    },
    :right => {
      :type => "Literal",
      :value => 8,
      :loc => {
        :start => {:line => 1, :column => 4},
        :end => {:line => 1, :column => 5}
    }},
    :loc => {:start=>{:line=>1, :column=>0}, :end=>{:line=>1, :column=>5}}
  },
  :loc=>{:start=>{:line=>1, :column=>0}, :end=>{:line=>1, :column=>5}}
}]

class MockV8
  class Array
  end
end

class MockRhino
  class JS
    class NativeObject
    end
  end
end

describe Esprima::Parser do
  describe "#parse" do
    it "should parse a basic js expression" do
      result = Esprima::Parser.new.parse(EXPRESSION)
      result.should be_a(Esprima::AST)
      result[:body].should == AST_RESULT
    end

    it "should accept esprima options" do
      result = Esprima::Parser.new.parse(EXPRESSION, :loc => true)
      result.should be_a(Esprima::AST)
      result[:body].should == AST_RESULT_LOC
    end
  end

  describe "#parse_file" do
    it "should parse a basic js file" do
      parser = Esprima::Parser.new
      mock(parser).read_file("my_file.js") { EXPRESSION }
      result = parser.parse_file("my_file.js")
      result.should be_a(Esprima::AST)
      result[:body].should == AST_RESULT
    end

    it "should parse a basic js file with esprima options" do
      parser = Esprima::Parser.new
      mock(parser).read_file("my_file.js") { EXPRESSION }
      result = parser.parse_file("my_file.js", :loc =>  true)
      result.should be_a(Esprima::AST)
      result[:body].should == AST_RESULT_LOC
    end
  end


  describe "#js_type_of?" do
    it "returns true if the object's class name includes the given text, false otherwise" do
      parser = Esprima::Parser.new

      mock_arr = MockV8::Array.new
      parser.send(:js_type_of?, mock_arr, :array).should be_true
      parser.send(:js_type_of?, mock_arr, :object).should be_false

      mock_obj = MockRhino::JS::NativeObject.new
      parser.send(:js_type_of?, mock_obj, :array).should be_false
      parser.send(:js_type_of?, mock_obj, :object).should be_true
    end
  end
end
