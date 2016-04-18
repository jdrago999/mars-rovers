
require 'simplecov'
SimpleCov.start
SimpleCov.minimum_coverage 100

require 'rspec'
require 'bundler/setup'
require 'byebug'
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_support/core_ext/hash'
require 'mars'

RSpec.configure do |config|
end
