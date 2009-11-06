desc "Clear all cache from varnish"
namespace :varnish do
  task :clear => :environment do
    Varnish::MClient.new.purge :url, '.*'
  end
end