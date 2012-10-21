class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :member, :counter_cache => :rating

  validates :user_id, uniqueness: {scope: :member_id}

  attr_accessible :user, :member
end
