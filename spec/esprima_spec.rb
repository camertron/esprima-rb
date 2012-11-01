# encoding: UTF-8

require "spec_helper"

describe Esprima do
  describe "#load_path" do
    it "esprima.js should exist at the load path" do
      File.should exist(File.join(Esprima.load_path, "esprima.js"))
    end
  end

  describe "#new_environment" do
    it "creates a new environment that can be used to parse javascript code" do
      env = Esprima.new_environment
      env.parse("1 + 1").should_not be_nil
    end
  end
end