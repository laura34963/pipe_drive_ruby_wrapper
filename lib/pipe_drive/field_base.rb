module PipeDrive
  class FieldBase < Base
    def add_to_custom_field_keys
      resource = self.class.correspond_resource.to_sym
      PipeDrive.custom_field_keys[resource][name.parameterize] = key
    end

    class << self do

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
        new_field.add_to_custom_field_keys
      end

      def custom_field_setup
        resource = correspond_resource.to_sym
        list.each do |field|
          PipeDrive.custom_field_keys[resource][field.name.parameterize] = field.key
        end
      end

    end
  end
end