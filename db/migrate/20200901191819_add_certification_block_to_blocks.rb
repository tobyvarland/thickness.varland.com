class AddCertificationBlockToBlocks < ActiveRecord::Migration[6.0]
  def change
    add_column :blocks, :include_on_certification, :boolean, null: false, default: false
  end
end
