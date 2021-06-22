require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'goods_nameカラム' do
      it '空欄でないこと' do
        post.goods_name = ''
        is_expected.to eq false
      end
    end

    context 'captionカラム' do
      it '空欄でないこと' do
        post.caption = ''
        is_expected.to eq false
      end
      it '500文字以下であること: 500文字は〇' do
        post.caption = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '500文字以下であること: 501文字は×' do
        post.caption = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end