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
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # 自分がフォローしている人
  has_many :followings, through: :active_relationships, source: :follower
  #フォローされる
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  # 自分をフォローしている人
  has_many :followers, through: :passive_relationships, source: :following

  # ユーザーをフォローする
  def follow(current_user_id, user_id)
    active_relationships.create(following_id: current_user_id, follower_id: user_id )
  end

  # ユーザーのフォローを外す
  def unfollow(current_user_id, user_id)
    active_relationships.find_by(following_id: current_user_id, follower_id: user_id).destroy
  end

  #フォローしてたらtrueを返す
  def following?(user)
    followings.include?(user)
  end

  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@test.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
