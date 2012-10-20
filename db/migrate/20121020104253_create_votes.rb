class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :member

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :member_id
  end
end
