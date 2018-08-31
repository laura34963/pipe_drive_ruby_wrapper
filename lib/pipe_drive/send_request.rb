module PipeDrive
  class SendRequest
    attr_reader :host

    def initialize
      raise MissingApiToken.new if PipeDrive.api_token.nil?
      @host = PipeDrive.host
      @api_token = PipeDrive.api_token
    end

    def http_get(path, params={}, header={}, &block)
      begin
        full_url = "#{host}/#{API_VERSION}#{path}"
        uri = URI(full_url)
        params.merge!(api_token: @api_token)
        uri.query = URI.encode_www_form(params)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'

        request = Net::HTTP::Get.new(uri.request_uri, header)
        response = http.request(request)
        result = handle_response(response)
      rescue Exception => e
        result = server_error_response(e.message)
      end
      return result unless block_given?
      raise RequestError.new(result) unless success_result?(result)
      yield PipeDrive.hash_except(result, [:status])
    end

    def http_post(path, params={}, header={}, &block)
      body_request(:post, path, params, header, &block)
    end

    def http_put(path, params={}, header={}, &block)
      body_request(:put, path, params, header, &block)
    end

    def http_del(path, params={}, header={}, &block)
      body_request(:delete, path, params, header, &block)
    end

    protected

    def body_request(method, path, params={}, header={}, &block)
      begin
        full_url = "#{host}/#{API_VERSION}#{path}?api_token=#{@api_token}"
        uri = URI(full_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'
        header['Content-Type'] = 'application/json'

        request = Net::HTTP.const_get(method.to_s.capitalize).new(uri.request_uri, header)
        request.body = params.to_json
        response = http.request(request)
        result = handle_response(response)
      rescue Exception => e
        result = server_error_response(e.message)
      end
      return result unless block_given?
      raise RequestError.new(result) unless success_result?(result)
      yield PipeDrive.hash_except(result, [:status])
    end

    private

    def handle_response(response)
      result = {status: response.code.to_i}

      begin
        body = Oj.load(response.body)
      rescue
        body = {body: response.body}
      end
      body = deep_symbolize_keys(body)
      result.merge body
    end

    def server_error_response(err_msg)
      {status: 500, message: err_msg}
    end

    def success_result?(result)
      result[:status].is_a?(Integer) && (result[:status] / 100 == 2)
    end

    def deep_symbolize_keys(data)
      new_data = {}
      data.each_pair do |key, value|
        if value.is_a?(Hash)
          new_data[key.to_sym] = deep_symbolize_keys(value)
        elsif value.is_a?(Array)
          new_data[key.to_sym] = value.map do |v|
            deep_symbolize_keys(v)
          end
        else
          new_data[key.to_sym] = value
        end
      end
      new_data
    end
  end
end