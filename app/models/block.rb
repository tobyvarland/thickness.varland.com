class Block < ApplicationRecord

  # Relationships.
  belongs_to  :xray
  belongs_to  :user
  has_many    :readings,
              dependent:  :restrict_with_error

  # Scopes.

  # Callbacks.

  # Instance methods.

  # Calculates stats. Called from associated reading after update/destroy.
  def calculate_stats
    if self.readings.empty?
      self.destroy
      return
    end
    self.count_readings = self.readings.size
    self.mean_thickness = self.readings.average(:thickness)
    self.min_thickness = self.readings.minimum(:thickness)
    self.max_thickness = self.readings.maximum(:thickness)
    variance = self.readings.average("POWER(thickness - #{self.mean_thickness}, 2)")
    self.std_dev_thickness = Math.sqrt(variance)
    self.has_alloy = self.readings.with_alloy.size > 0
    if self.has_alloy
      self.mean_alloy = self.readings.with_alloy.average(:alloy)
      self.min_alloy = self.readings.with_alloy.minimum(:alloy)
      self.max_alloy = self.readings.with_alloy.maximum(:alloy)
      variance = self.readings.with_alloy.average("POWER(alloy - #{self.mean_alloy}, 2)")
      self.std_dev_alloy = Math.sqrt(variance)
    else
      self.mean_alloy, self.min_alloy, self.max_alloy, self.std_dev_alloy = nil, nil, nil, nil
    end
    self.save
  end

end