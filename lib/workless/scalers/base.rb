require 'delayed_job'

module Delayed
  module Workless
    module Scaler
  
      class Base
        def jobs
          Delayed::Job.where(:failed_at => nil)
        end
        
        def cached_workers
          @n_workers ||= workers()
        end
        
        def clear_cached_workers
          @n_workers = nil
        end
        
        def up
          if cached_workers == 0
            do_up
            clear_cached_workers
          end
        end
        
        def down
          unless cached_workers == 0 or jobs.count > 0
            do_down
            clear_cached_workers
          end
        end
          
      end
  
    end
  end
end