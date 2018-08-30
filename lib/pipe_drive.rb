require 'net/http'
require 'active_support/all'
require 'ostruct'
require 'oj'

module PipeDrive
  API_VERSION = 'v1'
  DEFAULT_PER_PAGE = 100
  STRICT = true

  RESOURCE_CLASSES = %w[Organization Person Deal]
  FIELD_CLASSES = %w[OrganizationField PersonField DealField]

  class << self; attr_accessor :api_token, :organization_name_for_host, :custom_field_keys, :stage_id; end

  class << self
    def setup
      self.custom_field_keys = Hash.new{|hash, key| hash[key] = {}}
      FIELD_CLASSES.each do |class_name|
        const_get(class_name).custom_field_setup
      end

      yield self
      self
    end

    def host
      "https://#{organization_name_for_host}.pipedrive.com"
    end

    def requester
      SendRequest.new(host)
    end
  end
end

require 'pipe_drive/base'
require 'pipe_drive/exception'
require 'pipe_drive/send_request'

require 'pipe_drive/resource_base'
require 'pipe_drive/organization'
require 'pipe_drive/person'
require 'pipe_drive/deal'

require 'pipe_drive/field_base'
require 'pipe_drive/organization_field'
require 'pipe_drive/person_field'
require 'pipe_drive/deal_field'
