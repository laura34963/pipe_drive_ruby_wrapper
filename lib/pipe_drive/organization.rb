module PipeDrive
  class Organization < Base
    ALLOW_FOR_SEARCH_TERMS = %i[name email]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[start limit]
  end
end