class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :channels, :name, unique: true
  end
end
