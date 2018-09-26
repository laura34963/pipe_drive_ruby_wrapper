module PipeDrive
  class Deal < ResourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[title]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[org_id person_id]

    def organization
      Organization.find_by_id(org_id)
    end

    def person
      Person.find_by_id(person_id)
    end
  end
end