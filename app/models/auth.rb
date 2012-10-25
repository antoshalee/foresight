class Auth < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid, :user, :domain

  validates :user, presence: true
end
