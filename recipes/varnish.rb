namespace :varnish do
  desc "clear the varnish cache"
  task :clear, :roles => :app, :only => {:cache_purger => true} do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    run "cd #{current_path}; #{rake} RAILS_ENV=#{rails_env} varnish:clear"
  end
end