# frozen_string_literal: true

class CreateInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :interests do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
