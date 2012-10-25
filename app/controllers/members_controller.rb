# -*- encoding : utf-8 -*-
class MembersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @member = Member.find params[:id]
    render 'start/index'
  end

  def participate
    return render_error 'Не заполнено поле "О себе"' if params[:message].blank?

    auth = current_user.current_auth
    provider = auth.provider
    uid = auth.uid
    domain = auth.domain

    if provider=='vkontakte'
      member = Member.find_by_vkontakte_uid(uid)
    elsif provider=='facebook'
      member = Member.find_by_facebook_uid(uid)
    end
    begin
      unless member
        create_member provider, domain, params[:message]
      end
    rescue Exception => e
      render status: 422, json: {errors: 'Произошла ошибка'+e.message}
    else
      render 'show'
    end
  end

  def create
    return render_error 'Не заполнено поле Рекомендация' if params[:message].blank?

    provider = 'vkontakte'

    domain = try_get_domain provider, params[:url]
    unless domain
      provider = 'facebook'
      domain = try_get_domain provider, params[:url]
    end

    unless domain
      return render status: 422, json: {errors: 'Неправильная ссылка'}
    end

    begin
      create_member provider, domain, params[:message]
    rescue VkontakteApi::Error
      render status: 422, json: {errors: 'Не удалось найти пользователя Vk'}
    rescue FbGraph::Unauthorized
      render status: 422, json: {errors: 'Не удалось найти пользователя Facebook'}
    rescue Exception => e
      render status: 422, json: {errors: e.message}
    else
      render 'show'
    end
  end

  def try_get_domain provider, url
    @social_manager = Social::ManagerFactory.get_manager_by_social_network provider
    @social_manager.extract_domain_from_url params[:url]
  end

  def create_member provider, domain, message
    if provider == "vkontakte"
      @member = build_member_by_vk_domain domain
    elsif provider == "facebook"
      @member = build_member_by_fb_domain domain
    end
    ActiveRecord::Base.transaction do
      @member.save!
      create_vote @member, message # adding a member means automatically voting for him
    end
  end

  def merge
    member = Member.find params[:id]
    merge_member = Member.find params[:merge_id]
    return render_error 'К первому участнику уже привязаны две соц.сети' if member.has_both_social?
    return render_error 'Ко второму участнику уже привязаны две соц.сети' if merge_member.has_both_social?
    return render_error 'Участники привязаны к одной и той же сети' if members_have_same_socials? member, merge_member

    begin
      authorize! :update, member
      member.merge merge_member
    rescue Exception => e
      render status: 422, json: {errors: 'Произошла ошибка' + e.message }
    else
      render json: {}
    end
  end

  def vote
    begin
      member = Member.find params[:id]
      create_vote member
      member.reload
    rescue Exception => e
      render status: 422, json: {errors: 'Произошла ошибка' + e.message }
    else
      render json: {rating: member.rating}
    end
  end

  def activate
    begin
      authorize! :update, @member
      @member = Member.find params[:id]
      @member.activated = true
      @member.save!
    rescue Exception => e
      render status: 422, json: {errors: 'Произошла ошибка' + e.message }
    else
      render :show
    end
  end

  def destroy
    authorize! :destroy, @member
    @member = Member.find(params[:id])
    begin
      @member.destroy
    rescue Exception => e
      render status: 422, json: {errors: 'Произошла ошибка' + e.message }
    else
      render json: {}
    end
  end

  private

  def members_have_same_socials? member1, member2
    (member1.has_vkontakte? && member2.has_vkontakte?) ||
    (member1.has_facebook? && member2.has_facebook?)
  end

  def build_member_by_vk_domain domain
    vk = VkontakteApi::Client.new
    vk_result = vk.users.get uids: domain, fields: 'photo,domain,photo_medium', lang: :ru
    member = Member.where(:vkontakte_uid => vk_result[0]['uid'].to_s).first_or_initialize
    fill_member_attributes_by_vk_result(member, vk_result) if member.new_record?
    member
  end

  def build_member_by_fb_domain domain
    user = FbGraph::User.fetch(domain)
    member = Member.new
    member = Member.where(:facebook_uid => user.identifier.to_s).first_or_initialize
    fill_member_attributes_by_fb_result(member, user) if member.new_record?
    member
  end

  def fill_member_attributes_by_fb_result member, fb_result
    member.facebook_uid = fb_result.identifier
    member.facebook_domain = fb_result.username
    member.first_name = fb_result.first_name
    member.last_name = fb_result.last_name

    array = FbGraph::Query.new(
      "SELECT pic FROM user WHERE uid = #{fb_result.identifier}"
    ).fetch
    member.photo = array[0]["pic"] if array[0]

    #member.photo = fb_result.picture :square
  end

  def fill_member_attributes_by_vk_result member, vk_result
    member.vkontakte_uid = vk_result[0]['uid']
    member.vkontakte_domain = vk_result[0]['domain']
    member.photo = vk_result[0]['photo_medium']
    member.first_name = vk_result[0]['first_name']
    member.last_name = vk_result[0]['last_name']
  end

  def create_vote member, message = nil
    raise 'Вы уже голосовали за этого участника' if (current_user.members.include? member)
    Vote.create!(member: member, user: current_user, message: message)
  end

end
