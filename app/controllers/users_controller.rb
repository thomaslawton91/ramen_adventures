class UsersController < ApiController
    include Response

    before_action :require_login, except: [:create]

    def create
        begin
            @user = User.new(user_params)
            @user.save!
            if @user.save
                json_response({ token: @user.auth_token })
            else
                json_response({ :errors => @user.errors.full_messages })
            end
        end
    end

    def show
        json_response(current_user)
    end

    def update
        @user = current_user
        @user.update_attributes(user_params)
        if @user.update_attributes(user_params)
            json_response(@user)
        else
            json_response( {:errors => @user.errors.full_messages })
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
