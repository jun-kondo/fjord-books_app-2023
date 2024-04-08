class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.integer :origin_id
      t.integer :destination_id

      t.timestamps
    end
    add_index :mentions, :origin_id
    add_index :mentions, :destination_id
    add_index :mentions, [:origin_id, :destination_id], unique: true
  end
end
