# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'ユーザー編集画面' do
    context '画像添付' do
      it 'アイコン画像を設定できる' do
        visit edit_user_registration_path
        fill_in 'user_current_password', with: user.password
        attach_file 'user[image]', Rails.root.join('spec/factories/kitten.jpg').to_s

        attached_user = User.first
        expect(attached_user.image).to be_attached
      end

    end
  end
end
