class AddSlugToDevicesAndOthers < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :slug, :string
    add_index :devices, :slug, unique: true

    add_column :locations, :slug, :string
    add_index :locations, :slug, unique: true

    add_column :links, :slug, :string
    add_index :links, :slug, unique: true
  end
end
