class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  attachment :profile_image
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@test.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
