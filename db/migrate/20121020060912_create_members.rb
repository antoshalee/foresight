class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :vkontakte_uid
      t.string :facebook_uid
      t.string :vkontakte_domain
      t.string :facebook_domain
      t.integer :rating
      t.string :first_name
      t.string :last_name
      t.string :photo
      t.timestamps
    end
    add_index :members, :vkontakte_uid
    add_index :members, :facebook_uid
    add_index :members, :rating
  end
end
