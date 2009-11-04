module Varnish
  class MClient
    attr_accessor :servers
    def initialize
      @servers = config.inject({}) do |h,(server,info)|
        h[server] = Varnish::Client.new [info["host"], info["port"]].join(":")
        h
      end
    end
    def config
      @config ||= YAML.load_file("#{RAILS_ROOT}/config/varnish.yml")[Rails.env].symbolize_keys
    end
  end
end

Varnish::MClient.class_eval do
  %w{vcl purge ping stats param status start stop running? stopped? disconnect connected?}.each do |method_name|
    self.send :define_method, method_name do |*args|
      @servers.inject({}){|h,(name, client)| h[name] = client.send(method_name, *args); h}
    end
  end
end