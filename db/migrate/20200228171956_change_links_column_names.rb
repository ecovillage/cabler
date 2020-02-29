class ChangeLinksColumnNames < ActiveRecord::Migration[6.0]
  def change
    change_table :links do |t|
      t.rename :slot_one_end, :port_one_end
      t.rename :slot_other_end, :port_other_end
    end
  end
end
