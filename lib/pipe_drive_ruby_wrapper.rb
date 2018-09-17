require 'net/http'
require 'ostruct'
require 'json'

module PipeDrive
  API_VERSION = 'v1'
  DEFAULT_PER_PAGE = 10
  STRICT = true

  RESOURCE_CLASSES = %w[Organization Person Deal]
  FIELD_CLASSES = %w[OrganizationField PersonField DealField]

  class << self; attr_accessor :api_token; end
  class << self; attr_writer :field_keys, :stage_ids; end

  class << self
    def setup
      yield self
      self
    end

    def field_keys
      return @field_keys unless @field_keys.nil? || @field_keys.empty?
      @field_keys = {}
      FIELD_CLASSES.each do |class_name|
        @field_keys.merge!(const_get(class_name).field_keys_map)
      end
      @field_keys
    end

    def reset_field_keys!
      @field_keys = {}
      FIELD_CLASSES.each do |class_name|
        @field_keys.merge!(const_get(class_name).field_keys_map)
      end
      @field_keys
    end

    def stage_ids
      return @stage_ids unless @stage_ids.nil? || @stage_ids.empty?
      @stage_ids = Stage.stage_ids_map
    end

    def reset_stage_ids!
      @stage_ids = Stage.stage_ids_map
    end

    def host
      "https://api.pipedrive.com"
    end

    def requester
      SendRequest.new
    end

    def hash_except(hash, except_keys)
      all_keys = hash.keys
      remain_keys = all_keys - except_keys
      hash.slice(*remain_keys)
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
require 'pipe_drive/activity'

require 'pipe_drive/overall_source_base'
require 'pipe_drive/pipeline'
require 'pipe_drive/stage'

require 'pipe_drive/field_base'
require 'pipe_drive/organization_field'
require 'pipe_drive/person_field'
require 'pipe_drive/deal_field'
