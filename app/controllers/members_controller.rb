# -*- encoding : utf-8 -*-
class MembersController < ApplicationController
  before_filter :authenticate_user!

  def create
    domain = extract_domain_from_vk_url params[:vk_url]
    unless domain
      render status: 422, json: {errors: 'Неправильная ссылка'}
      return
    end

    begin
      vk = VkontakteApi::Client.new session['vk_access_token']
      vk_result = vk.users.get uids: domain, fields: 'photo,domain,photo_medium'
      member = Member.new
      fill_member_attributes_by_vk_result(member, vk_result)
      ActiveRecord::Base.transaction do
        member.save!
        create_vote member # adding a member means automatically voting for him
      end
    rescue VkontakteApi::Error
      render status: 422, json: {errors: 'Не удалось найти пользователя Vk'}
    rescue Exception => e
      render status: 422, json: {errors: 'Произошла ошибка'}
    else
      render json: vk_result
    end
  end

  def vote
    begin
      member = Member.find params[:id]
      create_vote member
    rescue
      render status: 422, json: {errors: 'Произошла ошибка'}
    else
      render json: {}
    end
  end

  private

  def fill_member_attributes_by_vk_result member, vk_result
    member.vkontakte_uid = vk_result[0]['uid']
    member.vkontakte_domain = vk_result[0]['domain']
    member.photo = vk_result[0]['photo_medium']
    member.first_name = vk_result[0]['first_name']
    member.last_name = vk_result[0]['last_name']
  end

  def create_vote member
    Vote.create!(member: member, user: current_user)
  end

  def extract_domain_from_vk_url url
    s = url.scan(/^(http:\/\/)?(vk.com\/|vkontakte.ru\/)?([a-z0-9\._]+)$/)[0]
    return s.last if s
    nil
  end
end
