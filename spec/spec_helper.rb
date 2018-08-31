require 'bundler/setup'
require 'pipe_drive_ruby_wrapper'

Bundler.setup

ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |config|
  # some (optional) config here
end

PipeDrive.setup do |config|
  config.api_token = 'api_token'
  config.field_keys = {
    organization: {
      region: 'region key'
    },
    person: {
      role: 'role key'
    },
    deal: {
      product: 'product key'
    }
  }
  config.stage_ids = {
    1 => {test: 1}
  }
end