module Api
  class PropertiesController < ApplicationController
    def index
      use_case = Properties::UseCases::ListAllProperties.new

      properties = use_case.call(
        limit: params.fetch(:limit, 50).to_i
      )

      render json: {
        data: properties.map { |p|
          {
            title: p.title
          }
        }
      }
    rescue => e
      render json: {
        error: "Failed to load properties",
        details: e.message
      }, status: :internal_server_error
    end
  end
end
