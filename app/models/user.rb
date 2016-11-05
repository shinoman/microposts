class User < ActiveRecord::Base
    before_save {self.email = self.email.downcase } #データ保存前に小文字に変換
    validates :name, presence: true, length: {maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255 },format: {with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
    has_secure_password
=begin
    ・データベースに安全にハッシュ化（暗号化）されたpassword_digestを保存する。
    ・passwordとpassword_confirmationをモデルに追加して、パスワードの確認が一致するか検証する。
    ・パスワードが正しいときに、ユーザーを返すauthenticateメソッドを提供する。
=end
    validates :area, length:{ maximum:50 }
    validates :profile, length:{ minimum:2, maximum:1000 },allow_blank: true
    has_many :microposts #一つのユーザーテーブルで複数の投稿テーブルを持つことができる
=begin
belongs_to:userとhas_many:micropostsで自動生成されるメソッド
user.microposts         ユーザーの全投稿
microposts.user         投稿に関連されたユーザー
user.microposts.new     ユーザーの新規投稿を作成
user.microposts.create  ユーザーの投稿を作成して投稿
=end
    has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy 
=begin
一つのユーザーテーブルで複数のfollowing_relationshipsを持つことができる
foreign_keyでfollower_idにuser_idが入るようにしている。
そのためuser.following_relationshipsでuserがフォローしているrelationshipの集まりを取得できる
=end
    has_many :following_users, through: :following_relationships, source: :followed
=begin
一つのユーザーテーブルで複数のfollowing_usersを持つことができる
throughでfollowing_relationshipsを指定しているので、一つのfollowing_relationshipsテーブルを経由してから一つのfollowing_usersテーブルを取得できる
soureceでfollowedを指定しているのでfollower_idが対応するキーはfollowed_idとなる
=end

    has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
=begin
一つのユーザーテーブルで複数のfollower_relationshipsを持つことができる
foreign_keyでfollowed_idにuser_idが入るようにしている。
そのためuser.follower_relationshipsでuserがフォローされているrelationshipの集まりを取得できる
=end
    has_many :follower_users, through: :follower_relationships, source: :follower
=begin
一つのユーザーテーブルで複数のfollower_usersを持つことができる
throughでfollower_relationshipsを指定しているので、一つのfollower_relationshipsテーブルを経由してから一つのfollower_usersテーブルを取得できる
soureceでfollowerを指定しているのでfollowed_idが対応するキーはfollower_idとなる
=end
    #ほかのユーザーをフォローする
    def follow(other_user)
        following_relationships.find_or_create_by(followed_id: other_user.id)
=begin
現在のユーザーのfollowing_relationshipsの中からフォローするユーザーのuser_idを含むものを探し、
存在しない場合は、新しく作成します。find_or_create_byメソッドは引数のパラメータと一致するものを1件取得し、
存在する場合はそのオブジェクトを返し、存在しない場合は引数の内容で新しくオブジェクトを作成し、データベースに保存します。
=end
    end
    
    #フォローしているユーザーをアンフォローする
    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
=begin
following_relationshipsからフォローしているユーザーのuser_idが入っているものを探し、存在する場合は削除
=end
    end
    
    #あるユーザーをフォローしているかどうか？
    def following?(other_user)
        following_users.include?(other_user)
=begin
他のユーザーがfollowing_usersに含まれているかチェック
=end
    end
end
