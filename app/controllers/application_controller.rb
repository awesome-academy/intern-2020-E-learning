class ApplicationController < ActionController::Base
  include SessionsHelper
  include UserAssociationsHelper

  before_action :set_locale

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.default_locale
    I18n.locale = locale if I18n.available_locales.include?(locale)
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "message.user.require_login"
    redirect_to login_url
  end

  def get_current_user
    current_user
  end

  def get_current_user? user
    current_user? user
  end
end
