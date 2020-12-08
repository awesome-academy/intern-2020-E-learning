module SpecTestHelper
  def login user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm
    sign_in user
  end

  def current_user
    User.find_by id: request.session[:user_id]
  end

  def admin?
    current_user.admin?
  end
end
