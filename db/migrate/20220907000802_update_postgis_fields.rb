# frozen_string_literal: true

class UpdatePostgisFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :latlon
    add_column :users, :latlon, :st_point
  end
end
