# -*- encoding : utf-8 -*-
module ApplicationHelper
  def experts
    [
      [ 
        "Александра Меркулова",
        "Архитектор-урбанист, ведущий специалист, уполномоченный по развитию российских проектов KCAP Architects&Planners.",
        "kcap.eu/ru/kcap/", nil, "http://www.facebook.com/alexandra.merkulova", "/assets/experts/merkulova.jpg"],
      [ 
        "Илья Савчук",
        "СО РАН, вице-президент Торговой палаты, г. Новосибирск",
        "http://metaver.ru", "http://vk.com/id14303795", "http://facebook.com/ilya.savchuk", "/assets/experts/savchuk.jpg"],
      [
        "Юрий Воронов",
        "Генеральный директор консультационной фирмы «Корпус», вице-президент торгово-промышленной палаты, г. Новосибирск.",
        nil, nil, nil, "/assets/experts/voronov.jpg"],
      [
        "Валерий Ефимов",
        "Директор Центра стратегических исследований и разработок Сибирского федерального университета",
        "foresight.sfu-kras.ru", nil, "http://facebook.com/efimov.valerii", "/assets/experts/efimov.jpg"]
    ].map do |e|
      {name: e[0], role: e[1], web: e[2], vk_url: e[3], fb_url: e[4], img: e[5]}
    end
  end
end
