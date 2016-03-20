class UsersController < ApplicationController
  before_action :check_user, only: [:edit, :update]
  before_action :logged_in_user , only: [:edit, :update, :followings, :followers ]
  before_action :set_user, only: [:edit, :update, :followings, :followers ]
  
  def show # 追加
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end

  def edit
  end  

  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to @user #, notice: 'ユーザー情報を編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end  
  
  def followings
    @users = @user.following_users
  end
  
  def followers
    @users = @user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                  :password_confirmation, :profile, :location,
                  :url, :birthday )
  end
  
  def check_user
    unless  current_user == User.find(params[:id])  
      flash[:danger] = "不正な操作が行われました"
      redirect_to login_path
      #redirect_to logout_path
    end
  end

  def set_user
    @user = User.find(params[:id])  
  end
  
end
