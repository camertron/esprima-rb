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
  end

  describe "#parse_file" do
    it "should parse a basic js file" do
      parser = Esprima::Parser.new
      mock(parser).read_file("my_file.js") { EXPRESSION }
      result = parser.parse_file("my_file.js")
      result.should be_a(Esprima::AST)
      result[:body].should == AST_RESULT
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