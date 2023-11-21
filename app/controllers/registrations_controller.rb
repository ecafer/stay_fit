class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
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
            session[:user_id] = @user.id
            # Authentication successful, redirect to a secure area
            redirect_to root_path, notice: "Succesfully logged in"
        else
            # Authentication failed, show an error message
            flash.now[:alert] = "Invalid email or password"
            render :show
        end    
    end

    def logout
        if session[:user_id]
            # User is already logged-in
            session.delete(:user_id)
            redirect_to root_path, notice: "Succesfully logged out"
        else
            # User is not logged-in -> can't log out
            flash.now[:alert] = "No user is logged in."
            render :show
        end
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
