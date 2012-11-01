# encoding: UTF-8

require "spec_helper"

AST = [{
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

describe Esprima::AST do
  describe "#yieldable?" do
    it "esprima parser should only yield arrays and hashes" do
      ast = Esprima::AST.new({})
      ast.send(:'yieldable?', {}).should be_true
      ast.send(:'yieldable?', []).should be_true
      ast.send(:'yieldable?', "").should be_false
    end
  end

  context "with an ast" do
    before(:each) do
      @ast = Esprima::Parser.new.parse("7 + 8;")
    end

    describe "#each" do
      it "yields if a block is given" do
        @ast.each { |a| a.should be_a(Esprima::AST) }
      end

      it "returns an array of parse nodes" do
        result = @ast.each.map(&:tree)
        result.size.should == 5
        result.should include(AST)
        result.should include(AST.first)
        result.should include(AST.first[:expression])
        result.should include(AST.first[:expression][:left])
        result.should include(AST.first[:expression][:right])
      end
    end

    describe "#[]" do
      it "allows access to the internal tree with [] syntax" do
        @ast[:body][0][:type].should == "ExpressionStatement"
      end
    end

    describe "#is_hash?" do
      it "should return true if the underlying tree is a hash, false otherwise" do
        @ast.is_hash?.should be_true
        Esprima::AST.new(@ast.tree[:body], @ast.esprima).is_hash?.should be_false
      end
    end

    describe "#is_list?" do
      it "should return true if the underlying tree is an array, false otherwise" do
        @ast.is_list?.should be_false
        Esprima::AST.new(@ast.tree[:body], @ast.esprima).is_list?.should be_true
      end
    end

    describe "#to_ecma" do
      it "should build JavaScript code from the AST" do
        @ast.to_ecma.should == "7 + 8;"
      end
    end
  end
end