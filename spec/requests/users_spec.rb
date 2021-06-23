require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  
  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end
  
      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end
  
  describe 'ユーザログイン' do
    before do
      visit new_user_session_path
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'show' do
    context 'ログインしている場合' do
       before { sign_in user }
      it 'リクエストが成功すること' do
        get user_url(user)
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get user_url(user)
        expect(response.status).to redirect_to new_user_session_url
      end
    end
  end

  describe 'edit' do
    context 'ログインしている場合' do
      before { sign_in user }
      it 'リクエストが成功すること' do
        get edit_user_registration_url
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        get edit_user_registration_url
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'destroy' do
    context 'ログインしている場合' do
      before { sign_in user }
      context '本人の場合' do
        it '正常に削除されること' do
          expect { delete user_url(user) }.to change(User, :count).by(-1)
          expect(response).to redirect_to root_url
        end
      end

      context '本人以外の場合' do
        it '削除されないこと' do
          expect { delete user_url(other_user) }.not_to change(User, :count)
          expect(response).to redirect_to user_url(user)
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされること' do
        delete user_url(user)
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
