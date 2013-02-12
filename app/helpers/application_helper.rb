# -*- encoding : utf-8 -*-
module ApplicationHelper
  def experts
    [
      [
        "Илья Савчук",
        "Директор по программам развития проектной группы «Метавер», соразработчик Форсайта «Образование 2030». г. Москва",
        "metaver.ru", "http://vk.com/id14303795", "http://facebook.com/ilya.savchuk", "/assets/experts/savchuk.jpg"],
      [
        "Александра Меркулова",
        "Архитектор-урбанист, ведущий специалист, уполномоченный по развитию российских проектов KCAP Architects&Planners. г. Роттердам (Нидерланды)",
        "kcap.eu/ru/kcap/", nil, "http://www.facebook.com/alexandra.merkulova", "/assets/experts/merkulova.jpg"],
      [
        "Валерий Ефимов",
        "Директор Центра стратегических исследований и разработок Сибирского федерального университета. г. Красноярск",
        "foresight.sfu-kras.ru", nil, "http://facebook.com/efimov.valerii", "/assets/experts/efimov.jpg"],
      [
        "Федор Слюсарчук",
        "Разработчик интерактивных образовательных технологий. Методолог и мастер рефлексивных ролевых игр. Участник проектной группы «Метавер». г. Екатеринбург",
        "metaver.ru", nil, nil, "/assets/experts/slyusarchuk.jpg"]
    ].map do |e|
      {name: e[0], role: e[1], web: e[2], vk_url: e[3], fb_url: e[4], img: e[5]}
    end
  end
  def krskexperts
    [
      [
        "Антон Шаталов",
        "доцент Кафедры градостроительства ИАД СФУ, главный архитектор ТГИ «Красноярскгражданпроект»",
        nil, nil, nil, "/assets/experts/shatalov.jpg"],
      [
        "Александр Цаплин",
        "Заместитель руководителя департамента экономики администрации города Красноярска.",
        nil, nil, nil, "/assets/experts/tsaplin.jpg"],
      [
        "Михаил Васильев",
        "Председатель Союза промышленников и предпринимателей Красноярского края",
        nil, nil, nil, "/assets/experts/vasiliev.jpg"],
      [
        "Сергей Дубинцов",
        "Помощник генерального директора по работе с органами власти и корпоративным отношениям ОАО «Восточно-Сибирская нефтегазовая компания»",
        nil, nil, nil, "/assets/experts/dubintsov.jpg"]
    ].map do |e|
      {name: e[0], role: e[1], web: e[2], vk_url: e[3], fb_url: e[4], img: e[5]}
    end
  end

  def image_url(source)
    "#{root_url}#{image_path(source)}"
  end
end
