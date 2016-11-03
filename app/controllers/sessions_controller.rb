class SessionsController < ApplicationController
  def new
  end
  
  def create #入力されたメールアドレスとパスワードはparams[:session]に入っている。
    @user = User.find_by(email: params[:session][:email].downcase) #入力されたメールアドレスを小文字にしてユーザーを探す
    if @user && @user.authenticate(params[:session][:password]) #メールアドレスが一致するユーザーがいたらパスワードがあっているか照合する
      session[:user_id] = @user.id #あっていたらsessionハッシュハッシュのuser_idに代入する
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user #ユーザーページに偏移する
    else
      flash[:danger] = "invalid email/password combination"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
