class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :rescue_can3_exception
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_404_exception

  include SessionsHelper

  before_action :set_locale, :global_course_search

  def global_course_search
    @search = Course.ransack params[:search].try(:merge, m: "or"),
                             auth_object: set_ransackable_auth_object
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.default_locale
    I18n.locale = locale if I18n.available_locales.include?(locale)
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if user_signed_in?

    flash[:danger] = t "message.user.require_login"
    redirect_to new_user_session_path
  end

  def after_sign_in_path_for resource
    if current_user.admin?
      admin_root_url
    else
      stored_location_for(resource) || root_url
    end
  end

  def set_ransackable_auth_object
    current_user&.admin? ? :admin : nil
  end

  private

  def rescue_404_exception
    render file: Rails.root.join("public", "404.html").to_s, layout: false,
           status: :not_found
  end

  def rescue_can3_exception
    respond_to do |format|
      format.json{head :forbidden}
      format.html do
        render file: Rails.root.join("public", "403.html").to_s, layout: false,
               status: :forbidden
      end
    end
  end
end
