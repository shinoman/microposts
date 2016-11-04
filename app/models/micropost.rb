class Micropost < ActiveRecord::Base
  belongs_to :user #参照元テーブルから参照先テーブルにアクセスする:belongs_to(関連モデル名 [, scope, オプション])
  validates :user_id, presence: true #user_idが存在する
  validates :content, presence: true, length: { maximum: 140 } #contentが存在し、文字数は最大140
end
