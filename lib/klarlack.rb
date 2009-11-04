require 'socket'
require 'varnish/socket_factory'
require 'varnish/client'
require 'varnish/m_client'

module Varnish
  class Error < StandardError; end
  VERSION = '0.0.1'
end
