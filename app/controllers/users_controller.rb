class UsersController < ApplicationController
  before_action :set_user, :logged_in, only: [:show, :edit, :update]
  before_action :collation_user, only: [:edit]
  
  def show
  end
  
  def new
    @user = User.new # Userクラスの新しいインスタンスを作成して、UsersControllerのインスタンス変数@userに代入
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Sample App!" #flashというハッシュを作成してmessage_typeキーにsuccessを、messageにWelcome to the Sample App!をいれている
      redirect_to @user # redirect_to user_path(@user)と同様
    else
      render "new"
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "編集に成功しました"
      redirect_to @user # redirect_to user_path(@user)と同様
    else
      render "edit"
    end
  end
  
    private
    
  def user_params
    params.require(:user).permit(:name, :sexes, :email, :password, :password_confirmation, :area, :profile)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def logged_in
    if logged_in?
      else
        flash[:warning] = "ログインしてください。"
        redirect_to "/login"
    end
  end
  
  def collation_user
    @user = current_user
  end
end