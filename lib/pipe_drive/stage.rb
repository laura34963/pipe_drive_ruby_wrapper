module PipeDrive
  class Stage < OverallSourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[name]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[pipeline_name pipeline_id]

    class << self

      def stage_ids_map
        stage_ids_map = Hash.new {|hash, key| hash[key] = {}}
        list.each do |stage|
          pipeline_name = parameterize(stage.pipeline_name, '_').to_sym
          stage_name = parameterize(stage.name, '_').to_sym
          stage_ids_map[pipeline_name][stage_name] = stage.id
        end
        stage_ids_map
      end

    end

  end
end