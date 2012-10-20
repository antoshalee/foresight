class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :vkontakte_domain
      t.string :facebook_domain
      t.integer :rating
      t.string :first_name
      t.string :last_name
      t.string :photo
      t.timestamps
    end
    add_index :members, :vkontakte_domain
    add_index :members, :facebook_domain
    add_index :members, :rating
  end
end
