class AddDomainToAuths < ActiveRecord::Migration
  def change
    add_column :auths, :domain, :string
  end
end
