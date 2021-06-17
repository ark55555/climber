class Post < ApplicationRecord

  attachment :image

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
  
  # 現在ログインしているユーザーidを受け取り、記事をストックする
  def bookmark(user)
    bookmarks.create(user_id: user.id)
  end

  # 現在ログインしているユーザーidを受け取り、記事のストックを解除する
  def unbookmark(user)
    bookmarks.find_by(user_id: user.id).destroy
  end

end
