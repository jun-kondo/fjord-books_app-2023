# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
        expect(current_path).to eq books_path
      end
    end
    context '間違ったパスワードを入力' do
      it 'ログイン処理が失敗する' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: 'wrong_password'
        click_button 'ログイン'
        # expect(page).to have_content 'Login failed'
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe 'ログイン後' do
    before { sign_in(user) }

    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        visit user_path(user)
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
