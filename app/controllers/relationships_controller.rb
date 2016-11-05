class RelationshipsController < ApplicationController
    before_action :logged_in_user
    
    def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    end
=begin
フォローする他のユーザーのIDをパラメータとして受け取り、見つかったユーザーを引数としてUserモデルのfollowメソッドを実行します。
=end
    
    def destroy
        @user = current_user.following_relationships.find(params[:id]).followed
        current_user.unfollow(@user)
=begin
現在のユーザーのfollowing_relationshipsを検索して他のユーザーをフォローしている場合は、そのユーザーを引数としてUserのunfollowメソッドを実行
=end
    end
end
