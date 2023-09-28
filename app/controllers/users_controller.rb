class UsersController < ApplicationController
  before_action :find_user_id, except: :index

  def index
    @users = User.all
  end

  def edit; end

  def show
    @roles = @user.roles
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User data updated'
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = 'User deleted'
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
