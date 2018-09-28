module PipeDrive
  class Pipeline < OverallSourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[name]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[]

    class << self

      def pipeline_ids_map
        id_map = {}
        list.each do |pipeline|
          pipeline_name = parameterize(pipeline.name, '_').to_sym
          id_map[pipeline_name] = pipeline.id
        end
        id_map
      end

    end
  end
end