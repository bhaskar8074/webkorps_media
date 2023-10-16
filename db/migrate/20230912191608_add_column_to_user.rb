# frozen_string_literal: true

class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string, default: 'user'
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
