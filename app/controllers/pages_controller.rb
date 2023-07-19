class PagesController < Devise::SessionsController
  # before_action :authenticate_user!, except: [:home]
  def home
    self.resource = resource_class.new(sign_in_params)
    if current_user
      redirect_to movies_path
    end
  end
end
