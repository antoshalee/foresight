class Auth < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid, :user, :domain

  validates :user, presence: true

  def social_url
    if provider=="vkontakte"
      "http://vk.com/#{self.domain}"
    else
      "http://facebook.com/#{self.domain}"
    end
  end
end
