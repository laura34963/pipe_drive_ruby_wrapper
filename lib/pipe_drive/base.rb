module PipeDrive
  class Base < OpenStruct

    def initialize(attrs)
      struct_attrs = attrs[:data] || PipeDrive.hash_except(attrs, [:additional_data])
      struct_attrs.merge!(attrs[:additional_data]) unless attrs[:additional_data].nil?

      super(struct_attrs)
    end

    def requester
      PipeDrive.requester
    end

    def update(opts)
      path = "/#{self.class.resource_name}s/#{id}"
      opts = self.class.send(:transform_opts, opts)
      requester.http_put(path, opts) do |result|
        self.class.new(result)
      end
    end

    def delete
      path = "/#{self.class.resource_name}s/#{id}"
      requester.http_del(path)
    end

    def parameterize(target_string, separator)
      self.class.parameterize(target_string, separator)
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
        opts = transform_opts(opts)
        requester.http_post("/#{resource_name}s", opts) do |result|
          new(result)
        end
      end

      def update(id, opts)
        path = "/#{resource_name}s/#{id}"
        opts = transform_opts(opts)
        requester.http_put(path, opts) do |result|
          new(result)
        end
      end

      def delete(id)
        path = "/#{resource_name}s/#{id}"
        requester.http_del(path){|result| result}
      end

      def bulk_delete(ids)
        path = "/#{resource_name}s"
        params = {ids: ids.map(&:to_s).join(',')}
        requester.http_del(path, params){|result| result}
      end

      def search_and_setup_by(type, opts, strict=false)
        target = find_by(type, opts, strict)
        if target.nil?
          create(opts)
        else
          target.update(opts)
        end
      end

      def parameterize(target_string, separator)
        target_string.gsub!(/[\W_]+/, separator)
        target_string.downcase
      end

      protected

      def list_objects(attrs)
        return [] if attrs.nil? || attrs.empty?
        if attrs[:data].nil?
          struct_attrs = attrs
        elsif attrs[:additional_data].nil?
          struct_attrs = attrs[:data].map do |data|
            data
          end
        else
          struct_attrs = attrs[:data].map do |data|
            data.merge(attrs[:additional_data])
          end
        end

        struct_attrs.map do |struct_attr|
          new(struct_attr)
        end
      end

      def transform_opts(opts)
        new_opts = {}
        opts.each_pair do |key, value|
          raise FieldNotExist.new(key) if field_keys[key].nil?
          new_key = field_keys[key][:key]
          if value.is_a?(Array)
            field_info = field_class.find_by_id(field_keys[key][:id])
            new_value = value.map do |val|
              target = field_info.options.find{|f| f[:label] == val}
              target[:id] unless target.nil?
            end
            new_value.compact!
          else
            new_value = value
          end
          new_opts[new_key] = new_value
        end
        new_opts
      end
      
    end
  end
end