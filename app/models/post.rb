class Post < ApplicationRecord

  validates :name, presence: true
  validates :date, presence: true
  validates :weather, presence: true
  validates :time, presence: true
  validates :practice, presence: true
  validates :skill, presence: true
  validates :improvement, presence: true

  belongs_to :user

  # コメントのアソシエーション
  has_many :comments, dependent: :destroy

  # いいねのアソシエーション
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  # 検索
  def self.search(search)
    if search
      Post.where(['name LIKE(?) OR date LIKE(?)', "%#{search}%","%#{search}%"])
    end
  end

end