# -*- encoding : utf-8 -*-
module ApplicationHelper
  def experts
    [
      [ 
        "Илья Савчук",
        "Директор по программам развития проектной группы «Метавер», соразработчик Форсайта «Образование 2030». г. Москва",
        "metaver.ru", "http://vk.com/id14303795", "http://facebook.com/ilya.savchuk", "/assets/experts/savchuk.jpg"],
      [ 
        "Федор Слюсарчук",
        "г. Екатеринбург",
        nil, nil, nil, "/assets/experts/merkulova.jpg"],
      [
        "Валерий Ефимов",
        "Директор Центра стратегических исследований и разработок Сибирского федерального университета. г. Красноярск",
        "foresight.sfu-kras.ru", nil, "http://facebook.com/efimov.valerii", "/assets/experts/efimov.jpg"],
      [ 
        "Александра Меркулова",
        "Архитектор-урбанист, ведущий специалист, уполномоченный по развитию российских проектов KCAP Architects&Planners. г. Роттердам (Нидерланды)",
        "kcap.eu/ru/kcap/", nil, "http://www.facebook.com/alexandra.merkulova", "/assets/experts/merkulova.jpg"]
    ].map do |e|
      {name: e[0], role: e[1], web: e[2], vk_url: e[3], fb_url: e[4], img: e[5]}
    end
  end
end
