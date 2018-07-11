class UsersController < ApplicationController
  #非ログイン時サインイン画面にリダイレクト
  before_action :authenticate_manager!

	def edit
		@user_info = User.find(params[:user_id])
	end

  def update
  	@user_info = User.find(params[:id])
		@user_info.update(update_params)
    redirect_to controller: 'managers', action: 'index'
  end

  private
  def update_params
    params.require(:user).permit(:user_name, :user_department, :user_sex)
  end
end
