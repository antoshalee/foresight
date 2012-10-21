class AddMessageToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :message, :text
  end
end
