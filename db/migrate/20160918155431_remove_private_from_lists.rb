class RemovePrivateFromLists < ActiveRecord::Migration
  def change
    remove_column :lists, :private
  end
end
