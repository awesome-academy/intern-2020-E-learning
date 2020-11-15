module Authorization
  def require_admin
    return if current_user.admin?

    flash[:warning] = t "user.require_permission"
    redirect_to root_path
  end
end