class UsersController < ApplicationApiController
    before_action :set_user, only: %i[ show update destroy ]

    # GET /users
    def index
        @users = User.all

        respond_with_success @users.list
    end

    # GET /users/1
    def show
        return respond_with_not_found unless @user

        respond_with_success @user.show
    end

    # POST /users
    def create
        @user = User.new(user_params)

        unless @user.save
            return respond_with_error "User not created", @user.errors.full_messages
        end

        respond_with_success @user.show
    end

    # PATCH/PUT /users/1
    def update
        return respond_with_not_found unless @user

        unless @user.update(user_params)
            return respond_with_error "User not updated", @user.errors.full_messages
        end

        respond_with_success @user.show
    end

    # DELETE /users/1
    def destroy
        return respond_with_not_found unless @user

        unless @user.destroy
            return respond_with_error "User not deleted", @user.errors.full_messages
        end

        respond_with_success({message: 'User deleted'})
    end

    def logout
        return respond_with_not_found unless @user

        @current_session.destroy_all!

        respond_with_success 'Session destroyed!'
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find_by(id: params[:id])
        end

        # Only allow a list of trusted parameters through.
        def user_params
            params.expect(user: [ :name, :lastname, :email, :password, :birthdate, :role_id ])
        end
end
