module PipeDrive
  class NotAllowSearchType < StandardError
    def initialize(type=nil)
      super("#{type} not allow search type")
    end
  end

  class NotProvideAssignType < StandardError
    def initialize(type=nil)
      super("not provide #{type}")
    end
  end

  class TargetNotFound < StandardError
    def initialize(target_type)
      super("#{target_type} not found")
    end
  end

  class RequestError < StandardError
    def initialize(response)
      super(response.to_json)
    end
  end
end