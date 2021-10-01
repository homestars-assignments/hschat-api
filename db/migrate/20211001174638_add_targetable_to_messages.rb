class AddTargetableToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :targetable, polymorphic: true, null: false
  end
end
