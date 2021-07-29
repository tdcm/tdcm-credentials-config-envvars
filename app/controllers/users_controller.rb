class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to users_url, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @users = User.order(created_at: :desc)
    authorize @users
  end

  private
    def user_params
      params.require(:user).permit({role_ids: []})
    end
end
