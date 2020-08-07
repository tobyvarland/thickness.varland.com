class CreateBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :blocks do |t|
      t.references  :xray,              null: false,  foreign_key: true
      t.references  :user,              null: false
      t.string      :directory,         null: false
      t.string      :product,           null: false
      t.string      :application,       null: false
      t.datetime    :block_at,          null: false
      t.integer     :number,            null: false
      t.integer     :shop_order,        null: false
      t.integer     :load,              null: false
      t.boolean     :is_early,          null: false,  default: false
      t.boolean     :is_rework,         null: false,  default: false
      t.boolean     :is_strip,          null: false,  default: false
      t.string      :customer_code,     null: true,   default: nil
      t.string      :process_code,      null: true,   default: nil
      t.string      :part_number,       null: true,   default: nil
      t.string      :part_sub,          null: true,   default: nil
      t.integer     :part_control,      null: true,   default: nil
      t.string      :part_name_1,       null: true,   default: nil
      t.string      :part_name_2,       null: true,   default: nil
      t.string      :part_name_3,       null: true,   default: nil
      t.integer     :count_readings,    null: false,  default: 0
      t.boolean     :has_alloy,         null: false,  default: false
      t.float       :mean_thickness,    null: false,  default: 0
      t.float       :min_thickness,     null: false,  default: 0
      t.float       :max_thickness,     null: false,  default: 0
      t.float       :std_dev_thickness, null: false,  default: 0
      t.float       :mean_alloy,        null: true,   default: nil
      t.float       :min_alloy,         null: true,   default: nil
      t.float       :max_alloy,         null: true,   default: nil
      t.float       :std_dev_alloy,     null: true,   default: nil
      t.timestamps
    end
  end
end