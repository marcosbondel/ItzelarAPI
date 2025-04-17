
module Auth
    class SessionsController < ApplicationController
        include System::Jwt

        def sign_in
            user = User.find_by(email: sign_in_params[:email])

            if user.nil?
                return respond_with_not_found
            end

            if user.authenticate(sign_in_params[:password])
                return respond_with_success({ 
                    :message => "Sign in successful",
                    :token => encode({ user_id: user.id}),
                })
            else
                return respond_with_error "Invalid credentials"
            end

        end
        
        def sign_up
            new_user = User.new(
                :name => sign_up_params[:name],
                :lastname => sign_up_params[:lastname],
                :email => sign_up_params[:email],
                :password => sign_up_params[:password],
                :role => Role.find_by(name: "student")
            )

            if new_user.save
                return respond_with_success(
                    :message => "Sign up successful",
                )
            else
                return respond_with_error
            end

            respond_with_success response
        end
        
        def logout
            response = {
                :message => "Sign out successful",
            }
            respond_with_success response
        end

        private

        def sign_in_params
            params.permit(:email, :password)
        end
        
        def sign_up_params
            params.require(:user).permit(:name, :lastname, :email, :password)
        end
    end
end
