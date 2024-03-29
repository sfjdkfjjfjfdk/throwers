class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 validates :name, presence: true
 validates :event, presence:true

 has_one_attached :profile_image

 def get_profile_image(width, height)
     profile_image.variant(resize_to_limit: [width, height]).processed
 end

 has_many :posts, dependent: :destroy

 # いいねのアソシエーション
 has_many :likes, dependent: :destroy
 has_many :liked_posts, through: :likes, source: :post

 def liked_by?(post_id)
     likes.where(post_id: post_id).exists?
 end

 # コメントのアソシエーション
 has_many :comments, dependent: :destroy

 # フォローをした、されたの関係
 # class_name: "Relationship"でRelationshipテーブルを参照
 # foreign_key(外侮キー)で参照するカラムを指定
 has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
 has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

 # 一覧画面
 # 自分がフォローしている人
 has_many :following_user, through: :follower, source: :followed
 # 自分をフォローしている人
 has_many :follower_user, through: :followed, source: :follower

 # ユーザーをフォローする
 def follow(user_id)
     follower.create(followed_id: user_id)
 end

 # ユーザーのフォローを外す
 def unfollow(user_id)
     follower.find_by(followed_id: user_id).destroy
 end

 # フォローしていればtrueを返す
 def following?(user)
     following_user.include?(user)
 end

 # DM機能
 # 2人のユーザーが複数のメッセージ(message)を送る多対多の関係、
 has_many :messages, dependent: :destroy
 # UsersテーブルとRoomsテーブルは多対多の関係にあり、中間テーブルとしてEntriesテーブルを置く
 has_many :entries, dependent: :destroy

 # 検索
 def self.search(search)
   if search
      User.where(['name LIKE(?) OR event LIKE(?)', "%#{search}%","%#{search}%"])
   end
 end

end