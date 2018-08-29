require 'bundler/setup'
require "pipe_drive"

Bundler.setup

ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |config|
  # some (optional) config here
end