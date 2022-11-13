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

end