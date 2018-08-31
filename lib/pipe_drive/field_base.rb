module PipeDrive
  class FieldBase < Base
    def add_to_field_keys
      resource = self.class.correspond_resource.to_sym
      field_name = parameterize(name, '_').to_sym
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

      def field_keys_map
        field_keys_map = Hash.new{|hash, key| hash[key] = {}}
        resource = correspond_resource.to_sym
        list.each do |field|
          field_name = parameterize(field.name, '_').to_sym
          field_keys_map[resource][field_name] = field.key
        end
        field_keys_map
      end

      def cache_keys
        PipeDrive.field_keys[correspond_resource.to_sym]
      end

      def pipedrive_key_of(field_name)
        cache_field_name = parameterize(field_name, '_').to_sym
        pipedrive_key = cache_keys[cache_field_name]
        return pipedrive_key unless pipedrive_key.nil?
        PipeDrive.field_keys = nil
        pipedrive_key = cache_keys[cache_field_name]
        if pipedrive_key.nil?
          raise TargetNotFound.new(self.name, :name, field_name)
        else
          pipedrive_key
        end
      end

    end
  end
end