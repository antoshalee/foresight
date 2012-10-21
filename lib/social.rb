module Social

  class ManagerFactory
    def self.get_manager_by_social_network network
      return VkontakteManager.new if network=="vkontakte"
      return FacebooManager.new if network=="facebook"
      nil
    end
  end

  class SocialManager
    def extract_domain_from_url url
      s = url.scan(user_url_format)[0]
      return s.last if s
      nil
    end
  end

  class VkontakteManager < SocialManager
    def user_url_format
      /^(http:\/\/)?(vk.com\/|vkontakte.ru\/)?([a-zA-Z0-9\._]+)$/
    end
  end

  class FacebooManager < SocialManager
    def user_url_format
      /^(http:\/\/)?(www\.)?(facebook.com\/)?([a-zA-Z0-9\._]+)$/
    end
  end

end
