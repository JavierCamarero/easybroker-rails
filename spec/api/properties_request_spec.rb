require "rails_helper"

RSpec.describe "API /api/properties", type: :request do
  it "returns property data as JSON" do
    fake = Class.new do
      include Properties::Contracts::Provider

      def fetch_first_page(limit:)
        {
          "content" => [
            { "title" => "Casa Bonita", "public_id" => "EB-123" }
          ],
          "pagination" => {
            "limit" => limit,
            "page" => 1,
            "total" => 1,
            "next_page" => nil
          }
        }
      end

      def fetch_from_url(url)
        raise "not used"
      end
    end.new

    allow(Properties::UseCases::ListAllProperties).to receive(:new)
      .and_return(Properties::UseCases::ListAllProperties.new(client: fake))

    get "/api/properties"

    expect(response).to have_http_status(:ok)

    json = JSON.parse(response.body)
    expect(json["data"].length).to eq(1)
    expect(json["data"][0]["title"]).to eq("Casa Bonita")
  end
end
