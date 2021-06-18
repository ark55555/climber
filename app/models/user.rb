class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  #フォローする
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  # 自分がフォローしている人
  has_many :following, through: :following_relationships, source: :following
  #フォローされる
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  # 自分をフォローしている人
  has_many :followers, through: :follower_relationships, source: :follower


  #バリデーション----
  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  #フォローしているかを確認するメソッド
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end
  #フォローするときのメソッド
  def follow(other_user)
    following_relationships.create(following_id: other_user)
  end

  #フォローを外すときのメソッド
  def unfollow(other_user)
    following_relationships.find_by(following_id: other_user).destroy
  end

  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@test.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

end
