class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  def logged_in_user
    unless logged_in? #ログインしていない場合（logged_in?がfalseのとき）のみ処理を行います。
      store_location #store_locationメソッドで、アクセスしようとしたURLを保存しています。
      flash[:danger] = "Please log in" 
      redirect_to login_url #ログイン画面のURLにリダイレクトします。
    end
  end
  
end
