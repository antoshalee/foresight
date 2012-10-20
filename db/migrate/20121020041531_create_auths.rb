class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.string :provider
      t.string :uid
      t.references :user
      t.timestamps
    end
    add_index :auths, :user_id
    add_index :auths, :provider
    add_index :auths, :uid
  end
end
