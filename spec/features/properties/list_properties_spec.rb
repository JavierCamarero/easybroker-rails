require "rails_helper"

RSpec.describe Properties::UseCases::ListAllProperties do
  class FakeProvider
    include Properties::Contracts::Provider

    def fetch_first_page(limit:)
      {
        "content" => [
          { "title" => "Casa Bonita", "public_id" => "EB-123" },
          { "title" => "Loft Centro", "public_id" => "EB-456" }
        ],
        "pagination" => {
          "limit" => limit,
          "page" => 1,
          "total" => 2,
          "next_page" => nil
        }
      }
    end

    def fetch_from_url(_url)
      raise "should not be called in this test"
    end
  end

  it "returns a list of Property objects" do
    use_case = described_class.new(client: FakeProvider.new)

    properties = use_case.call(limit: 50)

    expect(properties.size).to eq(2)

    expect(properties[0].title).to eq("Casa Bonita")
    expect(properties[0].public_id).to eq("EB-123")

    expect(properties[1].title).to eq("Loft Centro")
    expect(properties[1].public_id).to eq("EB-456")
  end
end
