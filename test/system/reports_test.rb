# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @report = create(:report, user: @user)
  end

  test '日報作成' do
    sign_in(@user)
    visit new_report_path
    assert_text '日報の新規作成'
    title = '今日の日報'
    content = 'Railsのアプリを作成した。'
    fill_in 'タイトル', with: title
    fill_in '内容', with: content
    click_button '登録する'
    assert_text '日報が作成されました。'
    assert_text title
    assert_text content
  end
  test '日報更新' do
    sign_in(@user)
    visit report_path(@report)
    click_on 'この日報を編集'
    updated_title = '日報のタイトルを更新'
    updated_content = '日報の本文を更新'
    fill_in 'タイトル', with: updated_title
    fill_in '内容', with: updated_content
    click_button '更新する'
    assert_text '日報が更新されました'
    assert_text updated_title
    assert_text updated_content
  end
  test '日報削除' do
    sign_in(@user)
    visit report_path(@report)
    click_on 'この日報を削除'
    assert_text '日報が削除されました。'
  end
end
