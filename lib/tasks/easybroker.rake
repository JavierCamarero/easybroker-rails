namespace :easybroker do
  desc "List all property titles from EasyBroker"
  task list_properties: :environment do
    use_case = Properties::UseCases::ListAllProperties.new
    properties = use_case.call(limit: 50)

    properties.each do |property|
      puts "#{property.title}"
    end
  rescue => e
    warn "Error fetching properties: #{e.message}"
    exit 1
  end
end
