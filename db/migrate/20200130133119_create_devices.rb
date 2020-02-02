class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.references :location, null: true, foreign_key: true
      t.string :kind
      t.text   :description
      t.integer :num_links
      t.integer :num_link_rows
      t.integer :num_link_columns
      t.integer :num_link_blocks
      t.string :model
      t.string :manufacturer

      t.timestamps
    end
  end
end
