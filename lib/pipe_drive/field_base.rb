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

      def list(&block)
        path = "/#{resource_name}s"
        resources = requester.http_get(path) do |result|
          result[:data].nil? ? [] : list_objects(result)
        end
        resources.each do |resource|
          yield resource
        end if block_given?
        resources
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

      def pipedrive_key_of(field_name)
        cache_keys = PipeDrive.field_keys[correspond_resource.to_sym]
        cache_field_name = field_name.parameterize(separator: '_').to_sym
        pipedrive_key = cache_keys[cache_field_name]
        return pipedrive_key if pipedrive_key.present?
        list do |field|
          next unless field.name == field_name
          pipedrive_key = field.key
          break
        end
        pipedrive_key
      end

    end
  end
end