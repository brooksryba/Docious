# frozen_string_literal: true

class AddPostgisExtensionToDatabase < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'postgis'
    remove_column :users, :latitude
    remove_column :users, :longitude
    add_column :users, :latlon, :point
  end
end
