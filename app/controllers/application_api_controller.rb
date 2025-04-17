class ApplicationApiController < ApplicationController
    include System::Jwt
    before_action :authorize_request
    
    attr_reader :current_user

    private 

    def authorize_request
        header = request.headers['Authorization']
        token = header.split(' ').last if header
    
        decoded = decode(token)
        if decoded
          @current_user = User.find_by(id: decoded[0]['user_id'])
        else
          respond_with_unauthorized
        end
    end
end