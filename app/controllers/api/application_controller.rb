# -*- encoding : utf-8 -*-
class Api::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :create_json_object
  before_filter :flexible_auth_user


  def flexible_auth_user
    if params[:token].present?
    end
  end

   def create_json_object
     @json_result = JsonResult.new
     @json_result.status = true
     @json_result.msg = ""
     @json_result.code = ""
     @json_result.object = nil
   end

   def current_user
     @current_user ||=  current_user
   end


end
