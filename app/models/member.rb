class Member < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :vkontakte_uid, uniqueness: {allow_nil: true}
  validates :facebook_uid, uniqueness: {allow_nil: true}

  def name
    "#{first_name} #{last_name}"
  end
end
