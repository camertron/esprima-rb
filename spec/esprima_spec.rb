# encoding: UTF-8

require File.join(File.dirname(__FILE__), "spec_helper")

describe Esprima do
  describe "#load_path" do
    it "esprima.js should exist at the load path" do
      File.should exist(File.join(Esprima.load_path, "esprima.js"))
    end
  end
end