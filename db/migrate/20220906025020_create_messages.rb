# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.belongs_to :conversation
      t.integer :author_id
      t.string :content

      t.timestamps
    end
  end
end
