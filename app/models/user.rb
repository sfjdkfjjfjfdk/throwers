class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  # いいねのアソシエーション
  has_many :likes, dependent: :destroy
  # コメントのアソシエーション
  has_many :comments, dependent: :destroy

 # フォローをした、されたの関係
 # class_name: "Relationship"でRelationshipテーブルを参照
 # foreign_key(外侮キー)で参照するカラムを指定
 has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
 has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

 # 一覧画面
 # 自分がフォローしている人
 has_many :following_user, through: :follower, source: :followed
 # 自分をフォローしている人
 has_many :follower_user, through: :followed, source: :follower

 # フォローしたときの処理
 def follow(user_id)
  relationships.create(followed_id: user_id)
 end
 # フォローを外すときの処理
 def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
 end
 # フォローしているか判定
 def following?(user)
  # following_user.include?(user)
 end

end