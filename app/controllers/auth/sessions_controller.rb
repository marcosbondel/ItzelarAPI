
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
                    :token => token,
                    :default_path => current_session.user.role.default_path
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
            header = request.headers['Authorization']
            token = header.split(' ').last if header
            
            decoded = decode(token)

            return respond_with_unauthorized unless decoded
            
            @current_session = User::Session.find_by(
                :user_uuid => decoded[0]['sub'], 
                :session_uuid => decoded[0]['jti'],
            )

            return respond_with_error unless @current_session

            if @current_session.revoked_at?
                return respond_with_unauthorized 
            end

            unless @current_session.user_agent.eql? request.user_agent
                @current_session.update_attribute(:revoked_at, Time.current)
                return respond_with_unauthorized 
            end

            @current_session.destroy!

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
