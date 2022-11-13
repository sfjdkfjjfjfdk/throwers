class Post < ApplicationRecord

  belongs_to :user

  # いいねのアソシエーション
  has_many :likes, dependent: :destroy
  # コメントのアソシエーション
  has_many :comments, dependent: :destroy

  def liked_by?(post)
    likes.where(user_id: user.id).exists?
  end

end