class Post < ApplicationRecord

  belongs_to :user

  # いいねのアソシエーション
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  # コメントのアソシエーション
  has_many :comments, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end