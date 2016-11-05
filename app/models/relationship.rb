class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User" #Userクラスのオブジェクトとして指定
  belongs_to :followed, class_name: "User" #Userクラスのオブジェクトとして指定
end
