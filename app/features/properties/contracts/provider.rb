module Properties
  module Contracts
    module Provider
      def fetch_first_page(limit:)
        raise NotImplementedError, "#{self.class} must implement #fetch_first_page"
      end

      def fetch_from_url(url)
        raise NotImplementedError, "#{self.class} must implement #fetch_from_url"
      end
    end
  end
end
