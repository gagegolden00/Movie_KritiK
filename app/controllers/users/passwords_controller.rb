class Users::PasswordsController < Devise::PasswordsController

    def create
        self.resource = resource_class.send_reset_password_instructions(resource_params)
        yield resource if block_given?
    
        if successfully_sent?(resource)
          if resource.reset_password_token.present?
            respond_with({}, location: email_sent_url)
          else
            respond_with({}, location: reviews_url)
          end
        else
          respond_with(resource)
          
        end
      end

      def email_sent
      end

end