class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :conversations, table_name: :participants do |t|
      t.index :user_id
      t.index :conversation_id

      t.timestamps
    end
  end
end
