class RegistrationsController < Devise::RegistrationsController
  layout 'devise_layout'

  def new
    super
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation, :auth_token)
  end
end
