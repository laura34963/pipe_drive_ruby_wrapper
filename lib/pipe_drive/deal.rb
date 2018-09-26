module PipeDrive
  class Deal < ResourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[title]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[org_id person_id]

    def organization
      Organization.find_by_id(organization)
    end

    def person
      Person.find_by_id(contact_person)
    end
  end
end