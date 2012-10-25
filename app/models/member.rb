# -*- encoding : utf-8 -*-
class Member < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :vkontakte_uid, uniqueness: {allow_nil: true, message: 'Данный пользователь Вконтакте уже зарегистрирован как участник'}
  validates :facebook_uid, uniqueness: {allow_nil: true, message: 'Данный пользователь Facebook уже зарегистрирован как участник'}

  def name
    "#{first_name} #{last_name}"
  end

  def merge member
    if self.has_vkontakte?
      self.facebook_uid = member.facebook_uid
      self.facebook_domain = member.facebook_domain
    elsif self.has_facebook?
      self.vkontakte_uid = member.vkontakte_uid
      self.vkontakte_domain = member.vkontakte_domain
    end
    member.votes.each do |v|
      v.member = self if !self.users.include v.user
    end
  end

  def vkontakte_url
    "http://vk.com/#{vkontakte_domain}"
  end

  def facebook_url
    "http://facebook.com/#{facebook_domain}"
  end

  def has_vkontakte?
    self.vkontakte_uid?
  end

  def has_facebook?
    self.facebook_uid?
  end

  def has_both_social?
    self.has_vkontakte? && self.has_facebook?
  end

end
