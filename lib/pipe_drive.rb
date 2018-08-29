require 'net/http'
require 'active_support/all'
require 'ostruct'
require 'oj'

module PipeDrive
  autoload :Base,                 'pipe_drive/base'
  autoload :NotAllowSearchType,   'pipe_drive/exception'
  autoload :NotProvideAssignType, 'pipe_drive/exception'
  autoload :RequestError,         'pipe_drive/exception'
  autoload :SendRequest,          'pipe_drive/send_request'
  autoload :Organization,         'pipe_drive/organization'
  autoload :Person,               'pipe_drive/person'
  autoload :Deal,                 'pipe_drive/deal'

  class << self; attr_accessor :api_token, :organization_name_for_host, :custom_field_keys, :stage_id; end

  class << self
    def setup
      yield self
    end

    def host
      "https://#{organization_name_for_host}.pipedrive.com"
    end

    def requester
      SendRequest.new(host)
    end
  end
end
