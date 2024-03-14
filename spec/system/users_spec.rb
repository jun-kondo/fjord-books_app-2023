# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ユーザー新規作成' do
    context 'フォームの入力値が正常' do
      it 'ユーザーの登録が成功する' do
        new_user = build(:user)
        visit new_user_registration_path
        fill_in 'user_email', with: new_user.email
        fill_in 'user_password', with: new_user.password
        fill_in 'user_password_confirmation', with: new_user.password
        fill_in 'user_postal_code', with: '1234567'
        fill_in 'user_address', with: '東京都千代田区1-1'
        fill_in 'user_self_introduction', with: 'よろしくお願いします。'
        attach_file 'user[image]', "#{Rails.root}/spec/factories/sample.png"
        click_button 'アカウント登録'
        expect(page).to have_content 'アカウント登録が完了しました。'
        attached_new_user = User.first
        expect(attached_new_user.image).to be_attached
      end
    end
  end

  describe 'ユーザー一覧画面' do
    it 'ユーザーのアイコン画像が表示されている' do
      attached_user = create(:user, :attached_png)
      sign_in(attached_user)
      visit users_path
      expect(page).to have_selector "img[src$='sample.png']"
    end
  end

  describe 'ユーザー詳細画面' do
    it 'ユーザーのアイコン画像が表示されている' do
      attached_user = create(:user, :attached_png)
      sign_in(attached_user)
      visit user_path(attached_user)
      expect(page).to have_selector "img[src$='sample.png']"
    end
  end

  describe 'ユーザー編集画面' do
    before { sign_in(user) }

    context '画像添付' do
      it 'アイコン画像を設定できる' do
        file_name = 'sample.png'
        visit edit_user_registration_path
        fill_in 'user_current_password', with: user.password
        attach_file 'user[image]', "#{Rails.root}/spec/factories/#{file_name}"
        click_button '更新'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq user_path(user)
        attached_user = User.first
        expect(attached_user.image).to be_attached
      end

      it '許可された形式以外のファイルはアップロードできない' do
        file_name = 'sample.svg'
        visit edit_user_registration_path
        fill_in 'user_current_password', with: user.password
        attach_file 'user[image]', "#{Rails.root}/spec/factories/#{file_name}"
        click_button '更新'
        expect(page).to have_content 'アイコンのContent Typeが不正です'
        expect(current_path).to eq edit_user_registration_path
      end
    end
  end
end
