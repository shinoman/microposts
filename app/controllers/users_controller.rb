class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
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
    
    private
    
  def user_params
    params.require(:user).permit(:name, :sexes, :email, :password, :password_confirmation)
  end
end
