module Properties
  module UseCases
    class ListAllProperties
      def initialize(client: Properties::Services::EasyBrokerClient.new)
        unless client.is_a?(Properties::Contracts::Provider)
          raise ArgumentError, "Client must implement Provider"
        end

        @client = client
      end

      def call(limit: 50)
        properties = []

        page = @client.fetch_first_page(limit: limit)
        properties.concat(map_properties(page))

        while (next_page = page.dig("pagination", "next_page"))
          page = @client.fetch_from_url(next_page)
          properties.concat(map_properties(page))
        end

        properties
      end

      private

      attr_reader :client

      def map_properties(page)
        content = page["content"] || []
        content.map do |item|
          Properties::Data::Property.from_easybroker_hash(item)
        end
      end
    end
  end
end
