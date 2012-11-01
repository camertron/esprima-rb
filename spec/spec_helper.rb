# encoding: UTF-8

$:.push(File.dirname(__FILE__))

require 'rspec'
require 'esprima'

RSpec.configure do |config|
  config.mock_with :rr
end