# -*- encoding : utf-8 -*-
class MembersController < ApplicationController
  before_filter :authenticate_user!

  def create

    @social_manager = Social::ManagerFactory.get_manager_by_social_network params[:social_network]
    return render status: 422, json: {errors: 'Неизвестная соцсеть'} if !@social_manager

    domain = @social_manager.extract_domain_from_url params[:social_url]
    unless domain
      return render status: 422, json: {errors: 'Неправильная ссылка'}
    end

    if params[:social_network] == "vkontakte"
      create_member_by_vk_domain domain
    elsif params[:social_network] == "facebook"
      create_member_by_fb_domain domain
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

  private

  def create_member_by_vk_domain domain
    begin
      vk = VkontakteApi::Client.new
      vk_result = vk.users.get uids: domain, fields: 'photo,domain,photo_medium', lang: :ru
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
      render json: {}
    end
  end

  def create_member_by_fb_domain domain
    begin
      user = FbGraph::User.fetch(domain)
      member = Member.new
      fill_member_attributes_by_fb_result(member, user)
      ActiveRecord::Base.transaction do
        member.save!
        create_vote member # adding a member means automatically voting for him
      end
    rescue FbGraph::Unauthorized
      render status: 422, json: {errors: 'Не удалось найти пользователя Facebook'}
    rescue Exception => e
      render status: 422, json: {errors: 'Произошла ошибка'}
    else
      render json: {}
    end
  end

  def fill_member_attributes_by_fb_result member, fb_result
    member.facebook_uid = fb_result.identifier
    member.facebook_domain = fb_result.username
    member.first_name = fb_result.first_name
    member.last_name = fb_result.last_name
    member.photo = fb_result.picture :square
  end

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

end
