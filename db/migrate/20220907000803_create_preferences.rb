# frozen_string_literal: true

class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences do |t|
      t.belongs_to :user
      t.float :max_distance
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
