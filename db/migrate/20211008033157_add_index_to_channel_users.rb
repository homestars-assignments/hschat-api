class AddIndexToChannelUsers < ActiveRecord::Migration[6.1]
  def change
    add_index(:channels_users, [:user_id, :channel_id])
  end
end
