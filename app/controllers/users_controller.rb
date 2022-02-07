class UsersController < ApplicationController
    def index
      render json: User.all
    end
  
    def show
      if current_user
        render json: current_user, status: :ok
      else
        render json: "No one is logged in", status: :unauthorized
      end
    end
  
    def create
      user = User.create!(user_params)
      session[:user_id] = user.id
      render json: user, status: :created
    end
  
    def destroy
      user = User.find(params[:id])
      user.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound => error
      render json: { error: error.message }, status: :not_found
    end
  
    private
  
    def user_params
      params.permit(:username, :password)
    end
  end
  