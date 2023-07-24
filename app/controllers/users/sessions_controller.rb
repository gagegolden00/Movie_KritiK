class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: movies_path
  end

  def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      #respond_with(resource, serialize_options(resource)) # default devise redirect overwritten 
      redirect_to root_path
      flash[:notice] = "Invalid Email or Password"
      end

end
