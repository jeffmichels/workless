require 'heroku'

module Delayed
  module Workless
    module Scaler

      class HerokuCedar < Base

        require "heroku"

        def do_up
          client.ps_scale(ENV['APP_NAME'], type: 'worker', qty: 1)
        end

        def do_down
          client.ps_scale(ENV['APP_NAME'], type: 'worker', qty: 0)
        end

        def workers
          client.ps(ENV['APP_NAME']).count { |p| p["process"] =~ /worker\.\d?/ }
        end

        private

        def client
          @client ||= ::Heroku::Client.new(ENV['HEROKU_USER'], ENV['HEROKU_PASSWORD'])
        end

      end

    end
  end
end
