class CreateReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :readings do |t|
      t.references  :block,         null: false,  foreign_key: true
      t.integer     :number,        null: false
      t.datetime    :reading_at,    null: false
      t.float       :thickness,     null: false
      t.float       :alloy,         null: true,   default: nil
      t.float       :x_coordinate,  null: false
      t.float       :y_coordinate,  null: false
      t.float       :z_coordinate,  null: false
      t.timestamps
    end
  end
end