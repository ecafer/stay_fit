class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to root_path, notice: "Succesfully created account"
        else
            render :new
        end
    end

    def show
        render "show"
    end

    def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            # Authentication successful, redirect to a secure area
            redirect_to root_path, notice: "Succesfully logged in"
        else
            # Authentication failed, show an error message
            flash.now[:alert] = "Invalid email or password"
            render :show
        end    
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
