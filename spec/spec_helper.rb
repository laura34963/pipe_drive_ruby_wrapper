require 'bundler/setup'
require "pipe_drive"

Bundler.setup

ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |config|
  # some (optional) config here
end

PipeDrive.setup do |config|
  config.organization_name_for_host = 'kdanmobile'
  config.api_token = '1f320321b1eb07ed37ae120600c28207fc3b284f'
end