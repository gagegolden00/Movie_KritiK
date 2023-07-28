# lib/tasks/prefix_routes.rake

desc "** View a list of route prefixes **"

task :prefix_routes => :environment do
  def list_route_prefixes
    routes = Rails.application.routes.routes
    prefixes = routes.map { |r| r.name.to_s }.compact.uniq

    max_prefix_length = prefixes.max_by(&:length).length
    header = "Prefix".ljust(max_prefix_length + 4) + "| " + "Route Name"
    separator = "-" * (max_prefix_length + 4 + 3)

    puts header
    puts separator

    prefixes.each do |prefix|
      next if prefix.empty?
      puts prefix.ljust(max_prefix_length + 4) + "| " + prefix
    end
  end

  list_route_prefixes
end

