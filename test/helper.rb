require "bundler"
Bundler.setup

require 'simplecov'
SimpleCov.start do
  add_group 'Diffr', 'lib/diffr'
end

require 'minitest/autorun'
require 'diffr'

