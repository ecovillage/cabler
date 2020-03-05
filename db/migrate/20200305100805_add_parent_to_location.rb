class AddParentToLocation < ActiveRecord::Migration[6.0]
  def change
    add_reference :locations, :parent, null: true, foreign_key: { to_table: :locations }
  end
end
