require 'rush'

module Delayed
  module Workless
    module Scaler

      class Local < Base

        def do_up
          Rush::Box.new[Rails.root].bash("rake jobs:work", :background => true)
          true
        end

        def do_down
          Rush::Box.new.processes.filter(:cmdline => /rake jobs:work/).kill
          true
        end

        def workers
          Rush::Box.new.processes.filter(:cmdline => /rake jobs:work/).size
        end

      end
  
    end
  end
end