class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification_type
      t.integer :battle_id
      t.integer :sender_id
      t.integer :receiver_id
      t.text :message

      t.timestamps
    end
  end
end
