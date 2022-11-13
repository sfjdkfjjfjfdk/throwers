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

  # liked_by?メソッドで引数で渡されたユーザidがlikesテーブル内に存在するかを確認
  def liked_by?(post)
    likes.where(post_id: post_id).exists?
  end
end
