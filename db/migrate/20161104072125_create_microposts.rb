class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.references :user, index: true, foreign_key: true
=begin
user_idという外部キーをカラムに追加します。これによって、ユーザーと投稿が関連付けられます。
index: trueを指定することで、user_idに対してインデックスを作成し、指定したユーザーの投稿を高速に検索することができるようになります。
foreign_key: trueを指定することで、外部キー制約を設定して、usersテーブルに存在するidのみuser_idに入るようにしています。
=end
      t.text :content

      t.timestamps null: false
      t.index [:user_id, :created_at] #複合インデックス：投稿を指定ユーザーで絞り込んだ後、作成時間で検索や並び替えを行う処理が速くできるようになる
    end
  end
end
