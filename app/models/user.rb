class User < ActiveRecord::Base

  has_many :auths, dependent: :destroy, autosave: true

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :omniauthable

  attr_accessible :remember_me
  # attr_accessible :title, :body
end