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
  class << self; attr_writer :field_keys, :field_names, :stage_ids, :pipeline_ids; end

  class << self
    def setup
      yield self
      self
    end

    def field_infos
      return @field_infos unless @field_infos.nil? || @field_infos.empty?
      @field_infos = obtain_field_infos
    end

    def reset_field_infos!
      @field_infos = obtain_field_infos
    end

    def field_keys
      @fields_keys = field_infos[:key_map]
    end

    def field_names
      @field_names = field_infos[:name_map]
    end

    def stage_ids
      @stage_ids ||= Stage.stage_ids_map
    end

    def reset_stage_ids!
      @stage_ids = Stage.stage_ids_map
    end

    def pipeline_ids
      @pipeline_ids ||= Pipeline.pipeline_ids_map
    end

    def reset_pipeline_ids!
      @pipeline_ids = Pipeline.pipeline_ids_map
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

    private

    def obtain_field_infos
      field_infos = {key_map: {}, name_map: {}}
      FIELD_CLASSES.each do |class_name|
        infos = const_get(class_name).field_infos_map
        field_infos[:key_map].merge!(infos[:key_map])
        field_infos[:name_map].merge!(infos[:name_map])
      end
      field_infos
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
