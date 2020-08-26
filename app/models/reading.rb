class Reading < ApplicationRecord

  # Soft deletes.
  acts_as_paranoid

  # Relationships.
  belongs_to  :block

  # Scopes.
  default_scope { order(:reading_at) }
  scope :with_alloy,  -> { where.not(alloy: nil) }

  # Callbacks.
  after_save    :update_block_stats
  after_destroy :update_block_stats

  # Instance methods.

  # Updates stats for associated block after updating/deleting reading.
  def update_block_stats
    self.block.calculate_stats
  end

  # Returns array of fields for spreadsheet row.
  def spreadsheet_row
    fields = []
    fields << self.block.shop_order
    if self.block.shop_order == 111
      5.times do
        fields << ""
      end
    else
      fields << self.block.customer_code
      fields << self.block.process_code
      fields << self.block.part_number
      fields << self.block.part_sub
      fields << self.block.part_name.join("\n")
    end
    fields << self.block.load
    fields << self.block.is_rework
    fields << self.block.is_early
    fields << self.block.is_strip
    fields << self.block.xray_id
    fields << self.block.application
    fields << self.block.directory
    fields << self.block.product
    fields << self.block.number
    if self.block.user
      fields << self.block.user.employee_number
      fields << self.block.user.name
    else
      fields << ""
      fields << ""
    end
    fields << self.reading_at.strftime("%m/%d/%Y")
    fields << self.reading_at.strftime("%H:%M:%S")
    fields << self.thickness
    if self.alloy.blank?
      fields << ""
    else
      fields << self.alloy
    end
    fields << self.x_coordinate
    fields << self.y_coordinate
    fields << self.z_coordinate
    return fields
  end

  # Class methods.

  # Returns header row for spreadsheet.
  def self.header_row
    ["Shop Order",
     "Customer",
     "Process",
     "Part",
     "Sub",
     "Part Name",
     "Load",
     "Rework?",
     "Early?",
     "Strip?",
     "X-Ray",
     "Application",
     "Directory",
     "Product",
     "Block #",
     "Employee #",
     "Employee Name",
     "Date",
     "Time",
     "Thickness",
     "Alloy",
     "X",
     "Y",
     "Z"
    ]
  end

end