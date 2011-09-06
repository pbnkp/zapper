require "net/http"
require "uri"

REDIS = Redis.new

class App < Sinatra::Base
  helpers ::ViewHelpers::AssetsHelpers
  register Sinatra::Contrib::All

  get "/" do
    erb :index
  end

  get "/json", :provides => [:html, :json] do
    content_type 'application/json'
    Schedule::Italy::MediasetPremium.new(REDIS).data
  end
end
