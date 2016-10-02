class AddPermissionsToLists < ActiveRecord::Migration
  def change
    add_column :lists, :permissions, :integer
  end
end
