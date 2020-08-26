class Block < ApplicationRecord

  # Soft deletes.
  acts_as_paranoid

  # Relationships.
  belongs_to  :xray
  belongs_to  :user,
              optional: true
  has_many    :readings

  # Scopes.
  scope :with_alloy,  -> { where(has_alloy: true) }
  scope :sorted_by,   ->(sort) {
    return if sort.blank?
    case sort
    when 'newest'
      order(block_at: :desc)
    when 'oldest'
      order(:block_at)
    end
  }
  scope :on_or_after, ->(value) {
    return if value.blank?
    where("DATE(block_at) >= ?", value)
  }
  scope :on_or_before,  ->(value) {
    return if value.blank?
    where("DATE(block_at) <= ?", value)
  }
  scope :with_shop_order, ->(value) {
    return if value.blank?
    where(shop_order: value)
  }
  scope :with_load, ->(value) {
    return if value.blank?
    where(load: value)
  }
  scope :with_load_flag,  ->(flag, value) {
    return if value.blank?
    case value
    when '1'
      where("#{flag} IS TRUE")
    when '2'
      where("#{flag} IS FALSE")
    end
  }
  scope :with_rework, ->(value) {
    with_load_flag('is_rework', value)
  }
  scope :with_early,  ->(value) {
    with_load_flag('is_early', value)
  }
  scope :with_strip,  ->(value) {
    with_load_flag('is_strip', value)
  }
  scope :with_customer, ->(value) {
    return if value.blank?
    where(customer_code: value)
  }
  scope :with_process,  ->(value) {
    return if value.blank?
    where(process_code: value)
  }
  scope :with_part, ->(value) {
    return if value.blank?
    where(part_number: value)
  }
  scope :with_sub,  ->(value) {
    return if value.blank?
    where(part_sub: value)
  }
  scope :with_part_name,  ->(value) {
    return if value.blank?
    wildcarded = "%#{value}%"
    where("part_name_1 LIKE (?) OR part_name_2 LIKE (?) OR part_name_3 LIKE (?)", wildcarded, wildcarded, wildcarded)
  }
  scope :with_xray, ->(value) {
    return if value.blank?
    where(xray_id: value)
  }
  scope :with_application,  ->(value) {
    return if value.blank?
    where(application: value)
  }
  scope :with_directory,  ->(value) {
    return if value.blank?
    where(directory: value)
  }
  scope :with_product,  ->(value) {
    return if value.blank?
    where(product: value)
  }
  scope :with_operator,  ->(value) {
    return if value.blank?
    where(user_id: value)
  }
  scope :with_mean_thickness, ->(value) {
    return if value.blank?
    where("mean_thickness #{value}")
  }
  scope :with_min_thickness,  ->(value) {
    return if value.blank?
    where("min_thickness #{value}")
  }
  scope :with_max_thickness,  ->(value) {
    return if value.blank?
    where("max_thickness #{value}")
  }
  scope :with_std_dev_thickness,  ->(value) {
    return if value.blank?
    where("std_dev_thickness #{value}")
  }
  scope :with_mean_alloy, ->(value) {
    return if value.blank?
    with_alloy.where("mean_alloy #{value}")
  }
  scope :with_min_alloy,  ->(value) {
    return if value.blank?
    with_alloy.where("min_alloy #{value}")
  }
  scope :with_max_alloy,  ->(value) {
    return if value.blank?
    with_alloy.where("max_alloy #{value}")
  }
  scope :with_std_dev_alloy,  ->(value) {
    return if value.blank?
    with_alloy.where("std_dev_alloy #{value}")
  }

  # Callbacks.

  # Instance methods.

  # Returns part name fields as an array.
  def part_name
    return nil if self.part_name_1.blank? && self.part_name_2.blank? && self.part_name_3.blank?
    name = []
    name << self.part_name_1 unless self.part_name_1.blank?
    name << self.part_name_2 unless self.part_name_2.blank?
    name << self.part_name_3 unless self.part_name_3.blank?
    name
  end

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

  # Returns array of fields for spreadsheet row.
  def spreadsheet_row
    fields = []
    fields << self.shop_order
    if self.shop_order == 111
      5.times do
        fields << ""
      end
    else
      fields << self.customer_code
      fields << self.process_code
      fields << self.part_number
      fields << self.part_sub
      fields << self.part_name.join("\n")
    end
    fields << self.load
    fields << self.is_rework
    fields << self.is_early
    fields << self.is_strip
    fields << self.xray_id
    fields << self.application
    fields << self.directory
    fields << self.product
    fields << self.number
    if self.user
      fields << self.user.employee_number
      fields << self.user.name
    else
      fields << ""
      fields << ""
    end
    fields << self.block_at.strftime("%m/%d/%Y")
    fields << self.block_at.strftime("%H:%M:%S")
    fields << self.mean_thickness
    fields << self.min_thickness
    fields << self.max_thickness
    fields << self.std_dev_thickness
    if self.has_alloy
      fields << self.mean_alloy
      fields << self.min_alloy
      fields << self.max_alloy
      fields << self.std_dev_alloy
    else
      4.times do
        fields << ""
      end
    end
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
     "Mean Thickness",
     "Minimum Thickness",
     "Maximum Thickness",
     "Std Dev Thickness",
     "Mean Alloy",
     "Minimum Alloy",
     "Maximum Alloy",
     "Std Dev Alloy"
    ]
  end

end