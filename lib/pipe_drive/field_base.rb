module PipeDrive
  class FieldBase < Base
    def add_to_field_keys
      resource = self.class.correspond_resource.to_sym
      field_name = name.parameterize(separator: '_').to_sym
      PipeDrive.field_keys[resource][field_name] = key
    end

    class << self

      def correspond_resource
        resource_name.sub('Field', '')
      end

      def list
        path = "/#{resource_name}s"
        requester.http_get(path) do |result|
          result[:data].nil? ? nil : list_objects(result)
        end
      end

      def create(opts)
        new_field = super(opts)
        new_field.add_to_field_keys
      end

      def custom_field_setup
        resource = correspond_resource.to_sym
        list.each do |field|
          field_name = field.name.parameterize(separator: '_').to_sym
          PipeDrive.field_keys[resource][field_name] = field.key
        end
      end

    end
  end
end