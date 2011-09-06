Encoding.default_external = 'utf-8'

# require all the gems from the bundle
require 'bundler'
Bundler.require

# all your classes belong to us
require 'active_support/dependencies'
ActiveSupport::Dependencies.autoload_paths \
  << "#{File.join(File.dirname(__FILE__), 'lib')}"

require './app'

# Initializeing Sprockets
sprockets = Sprockets::Environment.new do |env|
  env.logger = Logger.new(STDOUT)
end

sprockets.append_path 'assets/stylesheets'
sprockets.append_path 'assets/javascripts'
sprockets.append_path 'assets/images'

sprockets.context_class.instance_eval do
  include ::ViewHelpers::AssetsHelpers
end

map "/assets" do
  run sprockets
end

map "/" do
  run App
end
