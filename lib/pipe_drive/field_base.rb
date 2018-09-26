module PipeDrive
  class FieldBase < Base
    def add_to_field_infos
      resource = self.class.correspond_resource.to_sym
      field_name = parameterize(name, '_')
      PipeDrive.field_keys[resource][field_name.to_sym] = {id: id, key: key}
      PipeDrive.field_names[resource][key] = {id: id, name: field_name}
    end

    class << self

      def resource_class
        PipeDrive.const_get(correspond_resource.capitalize)
      end

      def field_class
        self
      end

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
        new_field.add_to_field_infos
      end

      def field_infos_map
        field_keys_map = Hash.new{|hash, key| hash[key] = {}}
        field_names_map = Hash.new{|hash, key| hash[key] = {}}
        resource = correspond_resource.to_sym
        list.each do |field|
          field_name = parameterize(field.name, '_')
          field_keys_map[resource][field_name.to_sym] = {id: field.id, key: field.key}
          field_names_map[resource][field.key] = {id: field.id, name: field_name}
        end
        {key_map: field_keys_map, name_map: field_names_map}
      end

      def cache_keys
        PipeDrive.field_keys[correspond_resource.to_sym]
      end

      def cache_names
        PipeDrive.field_names[correspond_resource.to_sym]
      end

      def pipedrive_key_of(field_name)
        cache_field_name = field_name.is_a?(String) ? parameterize(field_name, '_').to_sym : field_name
        pipedrive_key = cache_keys[cache_field_name]
        return pipedrive_key[:key] unless pipedrive_key.nil?
        PipeDrive.reset_field_infos!
        pipedrive_key = cache_keys[cache_field_name]
        if pipedrive_key.nil?
          raise TargetNotFound.new(self.name, :field_name, field_name)
        else
          pipedrive_key[:key]
        end
      end

      def pipedrive_name_of(field_key)
        pipedrive_name = cache_names[field_key]
        return pipedrive_name[:name] unless pipedrive_name.nil?
        PipeDrive.reset_field_infos!
        pipedrive_name = cache_names[field_key]
        if pipedrive_name.nil?
          raise TargetNotFound.new(self.name, :field_key, field_key)
        else
          pipedrive_name[:name]
        end
      end

    end
  end
end