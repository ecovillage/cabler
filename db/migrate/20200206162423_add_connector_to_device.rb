class AddConnectorToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :connector, :boolean
  end
end
