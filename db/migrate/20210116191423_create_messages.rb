class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.belongs_to :conversation
      t.belongs_to :user
      t.text :content

      t.timestamps
    end
  end
end
