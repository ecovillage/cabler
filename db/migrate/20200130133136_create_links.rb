# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :name
      #t.references :location, null: false, foreign_key: true

      t.string :kind

      t.references :one_end, polymorphic: true
      t.references :other_end, polymorphic: true

      t.integer :slot_one_end
      t.integer :slot_other_end

      t.timestamps
    end
  end
end
