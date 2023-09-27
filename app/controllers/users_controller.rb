class UsersController < ApplicationController
  before_action :find_user_id, except: %i[index]
  def index
    @users = User.all
  end

  def edit
  end

  def show
    @role = @user.roles.first
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def find_user_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, role_ids: [])
  end
end
