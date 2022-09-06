# frozen_string_literal: true

class AddUserLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :latitude, :float, default: 0.0
    add_column :users, :longitude, :float, default: 0.0
  end
end
