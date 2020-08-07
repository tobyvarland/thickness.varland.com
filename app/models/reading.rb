class Reading < ApplicationRecord

  # Relationships.
  belongs_to  :block

  # Scopes.
  default_scope { order(reading_at: :desc) }
  with_alloy, -> { where.not(alloy: :nil) }

  # Callbacks.
  after_save    :update_block_stats
  after_destroy :update_block_stats

  # Instance methods.

  # Updates stats for associated block after updating/deleting reading.
  def update_block_stats
    self.block.calculate_stats
  end

end