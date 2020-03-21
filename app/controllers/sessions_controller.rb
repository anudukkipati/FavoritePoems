class SessionsController < ApplicationController

    def home
    end

    def create
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          flash[:notice] = "Sucessfully logged in!"
          redirect_to user_path(@user)
        else
          flash[:alert] = "Invalid credentials, please try again"
          redirect_to "/login"
        end
      end
     
      def google_auth
       
        @user = User.find_or_create_by(email: auth['info']['email']) do |u|
          u.name = auth['info']['name']
          u.password = SecureRandom.hex
        end
        if @user.save
          session[:user_id] = @user.id
          redirect_to user_path(@user)
          
        else
          redirect_to '/'
        end
      end


      def destroy
        session.clear
        redirect_to root_path
      end

      private

  def auth
    request.env['omniauth.auth']
  end
end