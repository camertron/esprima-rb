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
end