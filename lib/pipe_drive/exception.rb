module PipeDrive
  class MissingApiToken < StandardError
    def initialize
      err_msg = "api token not found, please setup with
      PipeDrive.setup do |config|
        config.api_token = [Your API Token]
      end
      "
      super(err_msg)
    end
  end

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
    def initialize(class_name, search_type, search_value)
      super("#{class_name}: search #{search_type} for #{search_value} not found")
    end
  end

  class RequestError < StandardError
    def initialize(response)
      super(response.to_json)
    end
  end
end