class Post < ApplicationRecord

  attachment :image

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  # バリデーション----
  validates :goods_name, presence: true
	validates :caption, presence: true, length: {maximum: 500}
	

  # 　いいねしているか判断
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # ブックマークしているか判断
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # 現在ログインしているユーザーidを受け取り、記事をストックする
  def bookmark(user)
    bookmarks.create(user_id: user.id)
  end

  # 現在ログインしているユーザーidを受け取り、記事のストックを外す
  def unbookmark(user)
    bookmarks.find_by(user_id: user.id).destroy
  end

  # タグを作成
  def save_tag(tags)
      current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
      old_tags = current_tags - tags
      new_tags = tags - current_tags

    # 既に存在するタグは削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

    # 新しいタグ作成
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << post_tag
    end
  end
  
  # キーワード
  def self.post_search(keyword)
    Post.where(['goods_name LIKE ? OR caption LIKE ?', "%#{keyword}%", "%#{keyword}%"])
  end

end
