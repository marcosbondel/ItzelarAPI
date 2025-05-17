class User::ProfilesController < ApplicationApiController

    def show
        respond_with_success @current_user.show
    end

end