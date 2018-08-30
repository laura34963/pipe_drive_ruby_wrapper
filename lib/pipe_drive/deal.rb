module PipeDrive
  class Deal < ResourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[title]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[org_id person_id]
  end
end