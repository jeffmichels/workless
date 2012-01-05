require 'heroku'

module Delayed
  module Workless
    module Scaler

      class Heroku < Base

        require "heroku"

        def do_up
          client.set_workers(ENV['APP_NAME'], 1)
        end

        def do_down
          client.set_workers(ENV['APP_NAME'], 0)
        end

        def workers
          client.info(ENV['APP_NAME'])[:workers].to_i
        end

        private

        def client
          @client ||= ::Heroku::Client.new(ENV['HEROKU_USER'], ENV['HEROKU_PASSWORD'])
        end

      end

    end
  end
end