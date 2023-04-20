class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      add_index :relationships, :followed_id
      add_index :relationships, %i[follower_id followed_id], unique: true

      t.timestamps
    end
  end
end
