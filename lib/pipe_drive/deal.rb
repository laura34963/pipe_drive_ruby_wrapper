module PipeDrive
  class Deal < ResourceBase
    ALLOW_FOR_SEARCH_TERMS = %i[title]
    ALLOW_FOR_ADDITION_SEARCH_OPTS = %i[org_id person_id]

    def organization
      pipedrive_org_id = org_id.is_a?(Hash) ? org_id[:value] : org_id
      Organization.find_by_id(pipedrive_org_id)
    end

    def person
      pipedrive_person_id = person_id.is_a?(Hash) ? person_id[:value] : person_id
      Person.find_by_id(pipedrive_person_id)
    end
  end
end