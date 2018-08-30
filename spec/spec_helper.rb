require 'bundler/setup'
require 'pipe_drive_ruby_wrapper'

Bundler.setup

ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |config|
  # some (optional) config here
end

PipeDrive.setup do |config|
  config.api_token = '1f320321b1eb07ed37ae120600c28207fc3b284f'
  config.field_keys = {
    organization: {
      region: 'rguwjiownuibnejaoijfon'
    },
    person: {
      role: 'sljgiashigowiojeasdgh'
    },
    deal: {
      product: 'aksjghisauhgkjsdkgnjk'
    }
  }
end