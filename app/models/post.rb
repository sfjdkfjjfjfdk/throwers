class Post < ApplicationRecord

  validates :name, presence: true
  validates :date, presence: true
  validates :weather, presence: true
  validates :time, presence: true
  validates :practice, presence: true
  validates :skill, presence: true
  validates :improvement, presence: true

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
 end


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