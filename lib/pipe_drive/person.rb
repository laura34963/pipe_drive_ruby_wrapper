module PipeDrive
  class Person < ResourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[name email]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[org_id start limit]

    def activities(start_from=0, per_page=DEFAULT_PER_PAGE, options={}, &block)
      path = "/persons/#{id}/activities"
      params = {start: start_from, limit: per_page}
      params.merge!(options)
      Activity.send(:pagination, path, params, &block)
    end

    def deals(start_from=0, per_page=DEFAULT_PER_PAGE, options={}, &block)
      path = "/persons/#{id}/deals"
      params = {start: start_from, limit: per_page}
      params.merge!(options)
      Deal.send(:pagination, path, params, &block)
    end
  end
end