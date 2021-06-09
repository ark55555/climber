class Post < ApplicationRecord

  attachment :image

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
