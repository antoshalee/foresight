class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :member, :counter_cache => :rating

  attr_accessible :user, :member
end
