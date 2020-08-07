class TimeclockRecord < ActiveRecord::Base
  self.abstract_class = true
  connects_to database: { writing:  :timeclock,
                          reading:  :timeclock }
end