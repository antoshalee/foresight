class User < ActiveRecord::Base

  has_many :auths, dependent: :destroy, autosave: true
  has_many :votes
  has_many :members, through: :votes


  devise :database_authenticatable, :registerable, :rememberable, :trackable, :omniauthable

  attr_accessible :remember_me

  def current_auth
    auths.first
  end

  def name
    "#{first_name} #{last_name}"
  end
end
