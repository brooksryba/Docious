# frozen_string_literal: true

class FlushOutModels < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :birthdate, :datetime, null: false
    add_column :users, :pinged_at, :datetime
    add_column :users, :deleted_at, :datetime
  end
end
