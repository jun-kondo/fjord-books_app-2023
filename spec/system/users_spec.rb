# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'ユーザー編集画面' do
    context '画像添付' do
      it 'アイコン画像を設定できる' do
        visit edit_user_registration_path
        attach_file 'user[image]', "#{Rails.root}/spec/factories/user_image.png"
        fill_in 'user_current_password', with: user.password
        click_button '更新'

        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq user_path(user)
        expect(user.image).to be_attached
      end
    end
  end
end
