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
      path = "/#{self.class.resource_name}s/#{id}"
      opts.transform_keys!{|key| custom_field_keys[key] || key}
      requester.http_put(path, opts) do |result|
        new(result)
      end
    end

    def delete
      path = "/#{self.class.resource_name}s/#{id}"
      requester.http_del(path)
    end

    class << self
      def requester
        PipeDrive.requester
      end

      def find_by_id(id)
        path = "/#{resource_name}s/#{id}"
        requester.http_get(path) do |result|
          result[:data].nil? ? nil : new(result)
        end
      end

      def create(opts)
        opts.transform_keys!{|key| custom_field_keys[key] || key}
        requester.http_post("/#{resource_name}s", opts) do |result|
          new(result)
        end
      end

      def search_and_setup_by(type, opts, strict=false)
        target = find_by(type, opts, strict)
        if target.present?
          target.update(opts)
        else
          create(opts)
        end
      end

      protected

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
      
    end
  end
end