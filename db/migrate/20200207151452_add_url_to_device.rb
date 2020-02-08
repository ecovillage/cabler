class AddUrlToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :url, :string
  end
end
