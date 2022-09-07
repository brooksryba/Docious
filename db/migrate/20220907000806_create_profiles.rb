# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      t.string :biography
      t.string :nickname
      t.integer :interests, array: true, default: []

      t.timestamps
    end
  end
end
