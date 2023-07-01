class PagesController < Devise::SessionsController
    def home
        self.resource = resource_class.new(sign_in_params)
    end
end