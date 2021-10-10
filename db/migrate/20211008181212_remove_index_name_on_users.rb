class RemoveIndexNameOnUsers < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, column: :name
  end
end
