
module Auth
    class SessionsController < ApplicationController
        include System::Jwt

        def sign_in
            user = User.find_by(email: sign_in_params[:email])
            
            if user.nil?
                return respond_with_not_found
            end

            if user.authenticate(sign_in_params[:password])

                current_session = user.sessions.create({
                    :ip_address => request.remote_ip,
                    :session_source => ::User::Session.session_sources[:web],
                    :last_used_at => Time.current,
                    :expires_at => 24.hours.from_now,
                    :user_agent => request.user_agent
                })

                token = encode({
                    :jti => current_session.session_uuid,
                    :sub => current_session.user_uuid,
                    :aud => 'web'
                })

                current_session.update_attribute(:session_token, token)

                return respond_with_success({ 
                    :message => 'Sign in successful',
                    # :token => encode({ user_id: user.id}),
                    :token => token,
                    :user => {
                        :id => user.id,
                        :name => user.name,
                        :lastname => user.lastname,
                        :email => user.email,
                        :role => user.role.name
                    }
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
                return respond_with_error "Error", new_user.errors.full_messages.join(", ")
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
            # params.permit(:email, :password)
            # params.fetch(:sign_in, {}).permit(:email, :password)
            params.require(:sign_in).permit(:email, :password)
        end
        
        def sign_up_params
            params.require(:sign_up).permit(:name, :lastname, :email, :password)
        end
    end
end
