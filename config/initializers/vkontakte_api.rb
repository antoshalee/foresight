# -*- encoding : utf-8 -*-

VkontakteApi.configure do |config|

  # faraday-адаптер для сетевых запросов
  config.adapter = :net_http
  # HTTP-метод для вызова методов API (:get или :post)
  config.http_verb = :get
  # параметры для faraday-соединения
  config.faraday_options = {
    ssl: {
      ca_path:  '/etc/ssl/certs'
    }
  }

  # логгер
  config.logger        = Rails.logger
  config.log_requests  = true  # URL-ы запросов
  config.log_errors    = true  # ошибки
  config.log_responses = false # удачные ответы
end

