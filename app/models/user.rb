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
    has_many :microposts #それぞれのユーザーは複数の投稿を持つことができる
=begin
belongs_to:userとhas_many:micropostsで自動生成されるメソッド
user.microposts         ユーザーの全投稿
microposts.user         投稿に関連されたユーザー
user.microposts.new     ユーザーの新規投稿を作成
user.microposts.create  ユーザーの投稿を作成して投稿
=end
end
