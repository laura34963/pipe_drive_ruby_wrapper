module PipeDrive
  class Person < Base
    ALLOW_FOR_SEARCH_TERMS = %i[name email]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[org_id start limit]
  end
end