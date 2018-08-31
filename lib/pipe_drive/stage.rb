module PipeDrive
  class Stage < OverallSourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[name]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[pipeline_name pipeline_id]

    class << self

      def setup_stage_ids
        list.each do |stage|
          pipeline_name = parameterize(stage.pipeline_name, '_').to_sym
          stage_name = parameterize(stage.name, '_').to_sym
          PipeDrive.stage_ids[pipeline_name][stage_name] = stage.id
        end
      end

    end

  end
end