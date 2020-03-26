class UsersController < ApplicationController


    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "You have sucessfully created an account, #{@user.name}!"
            redirect_to @user
        else
            flash[:alert] = "Account creation failed: #{@user.errors.full_messages.to_sentence}"
            render :new
        end

    end

    def show
        @user = User.find_by(id: params[:id])
    end

    private
    
    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

end
