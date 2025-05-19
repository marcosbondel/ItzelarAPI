class ApplicationApiController < ApplicationController
    include System::Jwt
    before_action :authenticate_request

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    attr_reader :current_user
    attr_reader :current_session
    
    private 

        def authenticate_request
            header = request.headers['Authorization']
            token = header.split(' ').last if header
            
            decoded = decode(token)

            return respond_with_unauthorized unless decoded
            
            @current_session = User::Session.find_by(
                :user_uuid => decoded[0]['sub'], 
                :session_uuid => decoded[0]['jti']
            )

            return respond_with_unauthorized "Please, sign in again" unless @current_session
            
            # We check if the token has been revoked
            if @current_session.revoked_at?
                return respond_with_unauthorized 
            end

            # Invalid User-Agent (attack)
            unless @current_session.user_agent.eql? request.user_agent
                @current_session.update_attribute(:revoked_at, Time.current)
                return respond_with_unauthorized 
            end

            # Check if the token has expired
            if @current_session.expires_at < Time.now
                return respond_with_unauthorized 'Token expired'
            end

            @current_user = @current_session.user
            @current_session.update_attribute(:last_used_at, Time.current)
        end

        def user_not_authorized
            respond_with_unauthorized "You're not allowed"
        end
end