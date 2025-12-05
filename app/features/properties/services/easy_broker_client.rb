require "net/http"
require "uri"
require "json"

module Properties
  module Services
    class EasyBrokerClient
        include Properties::Contracts::Provider
      BASE_URL = ENV.fetch("EASYBROKER_BASE_URL", "https://api.stagingeb.com")

      def initialize(api_key: ENV["EASYBROKER_API_KEY"])
        @api_key = api_key
      end

      def fetch_first_page(limit: 50)
        url = URI.join(BASE_URL, "/v1/properties")
        params = { limit: limit }

        request_get(url, params)
      end

      def fetch_from_url(url_string)
        url = URI.parse(url_string)
        request_get(url)
      end

      private

      attr_reader :api_key

      def request_get(uri, params = nil)
        uri = uri.dup
        if params && !params.empty?
          query = URI.encode_www_form(params)
          uri.query = [uri.query, query].compact.join("&")
        end

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == "https"

        request = Net::HTTP::Get.new(uri)
        request["X-Authorization"] = api_key

        response = http.request(request)

        unless response.is_a?(Net::HTTPSuccess)
          raise "EasyBroker API error: #{response.code} #{response.body}"
        end

        JSON.parse(response.body)
      end
    end
  end
end