module Properties
  module Data
    class Property
      attr_reader :title, :public_id

      def initialize(title:, public_id:)
        @title = title
        @public_id = public_id
      end

      def self.from_easybroker_hash(hash)
        new(
          title: hash["title"] || "Untitled",
          public_id: hash["public_id"]
        )
      end
    end
  end
end
