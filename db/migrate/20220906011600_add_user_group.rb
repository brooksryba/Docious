# frozen_string_literal: true

class AddUserGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :group, :integer, default: 0
  end
end
