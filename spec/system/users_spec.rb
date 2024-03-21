# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ユーザーの新規登録が成功する' do
        visit new_user_registration_path
        fill_in 'user_email', with: 'test@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(current_path).to eq books_path
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの登録が失敗する' do
        visit new_user_registration_path
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
        expect(current_path).to eq new_user_registration_path
      end
    end

    context '登録済みのメールアドレスを使用' do
      it 'ユーザーの登録が失敗する' do
        existed_user = create(:user)
        visit new_user_registration_path
        fill_in 'user_email', with: existed_user.email
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
        expect(page).to have_content 'Eメールはすでに存在します'
        expect(current_path).to eq new_user_registration_path
      end
    end
  end

  describe 'マイページ' do
    context 'ログインしていない状態' do
      it 'マイページへのアクセスが失敗し、ログイン画面にリダイレクトする' do
        visit user_path(user)
        expect(current_path).to eq new_user_session_path
      end
    end

    context 'フレンドリーフォワーディング' do
      it 'ログイン画面にリダイレクト後、認証するとマイページへリダイレクトされる' do
        visit user_path(user)
        expect(current_path).to eq new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content user.email
        expect(current_path).to eq user_path(user)
      end
    end
  end

  describe 'ユーザー一覧ページ' do
    context 'ログインしていない状態' do
      it 'ユーザー一覧へのアクセスが失敗し、ログイン画面にリダイレクトする' do
        visit users_path
        expect(current_path).to eq new_user_session_path
      end
    end

    context 'フレンドリーフォワーディング' do
      it 'ログイン画面にリダイレクト後、認証するとユーザー一覧へリダイレクトされる' do
        visit users_path
        expect(current_path).to eq new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content 'ユーザーの一覧'
        expect(page).to have_content user.email
        expect(current_path).to eq users_path
      end
    end
  end

  describe 'ユーザー編集ページ' do
    context 'ログインしていない状態' do
      it 'ユーザー編集へのアクセスが失敗し、ログイン画面にリダイレクトする' do
        visit edit_user_registration_path
        expect(current_path).to eq new_user_session_path
      end
    end

    context 'フレンドリーフォワーディング' do
      it 'ログイン画面にリダイレクト後、認証するとユーザー編集へリダイレクトされる' do
        visit edit_user_registration_path
        expect(current_path).to eq new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content 'ユーザー編集'
        expect(page).to have_field 'Eメール', with: user.email
        expect(current_path).to eq edit_user_registration_path
      end
    end
  end

  describe 'ログイン後' do
    before { sign_in(user) }

    describe 'ユーザー一覧ページ' do
      context 'ユーザーが一人の場合' do
        it 'ページネーションリンクが存在しない' do
          visit users_path
          expect(page).not_to have_css '.pagination'
        end
      end

      context 'ユーザーが26人以上の場合' do
        before do
          create_list(:user, 25)
          visit users_path
        end

        it 'ページネーションリンクが存在する' do
          expect(page).to have_css '.pagination'
        end

        it 'ユーザー一覧の2ページ目に移動できる' do
          click_link '次'
          expect(page).to have_selector '.page.current', text: '2'
        end
      end
    end

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          visit edit_user_registration_path
          fill_in 'user_email', with: 'update@example.com'
          fill_in 'user_password', with: 'updatepassword'
          fill_in 'user_password_confirmation', with: 'updatepassword'
          fill_in 'user_zip_code', with: '1234567'
          fill_in 'user_address', with: '東京都千代田区1-1'
          fill_in 'user_self_introduction', with: 'よろしくお願いします。'
          click_button '更新'
          expect(page).to have_content 'アカウント情報を変更しました。'
          expect(page).to have_content 'update@example.com'
          expect(page).to have_content '1234567'
          expect(page).to have_content '東京都千代田区1-1'
          expect(page).to have_content 'よろしくお願いします。'
          expect(current_path).to eq user_path(user)
        end
      end

      context '郵便番号を数字以外の文字で入力する' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_registration_path
          fill_in 'user_zip_code', with: 'abcdefg'
          click_button '更新'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content '郵便番号は数値で入力してください'
          expect(current_path).to eq edit_user_registration_path
        end
      end

      context '住所を100文字以上入力する' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_registration_path
          fill_in 'user_address', with: 'a' * 101
          click_button '更新'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content '住所は100文字以内で入力してください'
          expect(current_path).to eq edit_user_registration_path
        end
      end

      context '自己紹介文を400文字以上入力する' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_registration_path
          fill_in 'user_self_introduction', with: 'a' * 401
          click_button '更新'
          expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content '自己紹介は400文字以内で入力してください'
          expect(current_path).to eq edit_user_registration_path
        end
      end
    end
  end
end
