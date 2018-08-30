module PipeDrive
  class Pipeline < ResourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[name]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[]

    def deals(start_from=0, per_page=DEFAULT_PER_PAGE, options={}, &block)
      path = "/pipelines/#{id}/deals"
      params = {start: start_from, limit: per_page}
      params.merge!(options)
      pagination(path, params, &block)
    end

    class << self

      def search(type, opts)
        raise NotAllowSearchType.new(type) unless const_get('ALLOW_FOR_SEARCH_TERMS').include?(type)
        raise NotProvideAssignType.new(type) if opts[type].nil?
        allow_search_opts = const_get('ALLOW_FOR_ADDITION_SEARCH_OPTS') + [type]
        opts = opts.slice(*allow_search_opts)
        list.select do |resource|
          is_match = true
          opts.each_pair do |key, value|
            resource_value = resource.send(key)
            if resource_value.is_a?(String)
              (is_match = false) && break unless resource_value.include?(value)
            else
              (is_match = false) && break unless resource_value == value
            end
          end
          is_match
        end
      end

    end

  end
end