module PipeDrive
  class Activity < ResourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[user_id type start limit start_date end_date]

    def resource_name
      'activitie'
    end
  end
end