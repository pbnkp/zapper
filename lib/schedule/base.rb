module Schedule
  class Base

    module Base
      require "net/http"
      require "uri"

      def data!
        uri = URI.parse(xml_source)
        data = Hash.from_xml(Net::HTTP.get_response(uri).body)
        map(data).to_json
      end

      def data
        data!
      end

      def id
        self.class.name.underscore
      end
    end

    module Cached
      def data
        unless result = @redis.get(cache_key) then
          result = super
          @redis.set(cache_key, result)
        end
        result
      end

      def cache_key
        "#{id}-#{Time.now.to_date.to_s(:db)}"
      end
    end

    def initialize(redis, cached=true)
      if cached
        @redis = redis
        class << self
          include Cached
        end
      end
    end

    include Base
  end
end
