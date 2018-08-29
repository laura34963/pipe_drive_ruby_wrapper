module PipeDrive
  class Base < OpenStruct

    def initialize(attrs)
      struct_attrs = attrs[:data] || attrs.except(:additional_data)
      struct_attrs.merge!(attrs[:additional_data]) if attrs[:additional_data].present?

      super(struct_attrs)
    end

    def requester
      PipeDrive.requester
    end

    def update(opts)
      path = "/v1/#{self.class.resource_name}s/#{id}?api_token=#{PipeDrive.api_token}"
      opts.transform_keys!{|key| custom_field_keys[key] || key}
      requester.http_put(path, opts) do |result|
        new(result)
      end
    end

    class << self
      def requester
        PipeDrive.requester
      end

      def resource_name
        name.split('::').last.downcase
      end

      def custom_field_keys
        PipeDrive.custom_field_keys[resource_name.to_sym]
      end

      def list_objects(attrs)
        return [] if attrs.blank?
        if attrs[:data].present?
          if attrs[:additional_data].present?
            struct_attrs = attrs[:data].map do |data|
              data.merge(attrs[:additional_data])
            end
          else
            struct_attrs = attrs[:data].map do |data|
              data
            end
          end
        else
          struct_attrs = attrs
        end

        struct_attrs.map do |struct_attr|
          new(struct_attr)
        end
      end

      def find_by_id(id)
        path = "/v1/#{resource_name}s/#{id}"
        params = {api_token: PipeDrive.api_token}
        requester.http_get(path, params) do |result|
          result[:data].nil? ? nil : new(result)
        end
      end

      def search(type, opts)
        raise NotAllowSearchType.new(type) unless const_get('ALLOW_FOR_SEARCH_TERMS').include?(type)
        raise NotProvideAssignType.new(type) if opts[type].nil?
        params = {term: opts[type]}
        allow_search_opts = const_get('ALLOW_FOR_ADDITION_SEARCH_OPTS')
        params.merge!(opts.slice(*allow_search_opts))
        params.merge!(api_token: PipeDrive.api_token)
        requester.http_get("/v1/#{resource_name}s/find", params) do |result|
          result[:data].nil? ? nil : list_objects(result)
        end
      end

      def create(opts)
        opts.transform_keys!{|key| custom_field_keys[key] || key}
        requester.http_post("/v1/#{resource_name}s", opts) do |result|
          new(result)
        end
      end

      def search_and_setup_by(type, opts)
        targets = search(type, opts)
        if targets.present?
          targets.first.update(opts)
        else
          create(opts)
        end
      end
    end
  end
end