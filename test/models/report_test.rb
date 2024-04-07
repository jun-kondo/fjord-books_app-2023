# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report1 = create(:report)
    @report2 = create(:report, content: "http://localhost:3000/reports/#{@report1.id}")
  end

  test '#editable?' do
    me = create(:user)
    my_report = create(:report, user: me)
    assert my_report.editable?(me)
    another_user = create(:user)
    assert_not my_report.editable?(another_user)
  end
  test '#created_on' do
    report = create(:report, created_at: Time.zone.parse('2024-03-31 15:30:45'))
    assert_equal(Date.new(2024, 3, 31), report.created_on)
  end
  test '#save_mention: 新規作成時、本文に日報URLを含める場合、その日報に言及できる' do
    assert_includes(@report2.mentioning_reports, @report1)
    assert_includes(@report1.mentioned_reports, @report2)
  end
  test '#save_mention: 更新時、本文から日報URLを削除すると、言及関係が削除される' do
    @report2.update(content: '参考URLを削除')
    @report2.reload
    assert_not_includes(@report2.mentioning_reports, @report1)
    assert_not_includes(@report1.mentioned_reports, @report2)
  end
  test '#save_mention: 更新時、本文に日報URLを含める場合、その日報に言及できる' do
    report3 = create(:report)
    assert_not_includes(report3.mentioning_reports, @report1)
    assert_not_includes(@report1.mentioned_reports, report3)
    report3.update(content: "http://localhost:3000/reports/#{@report1.id}")
    assert_includes(report3.mentioning_reports, @report1)
    assert_includes(@report1.mentioned_reports, report3)
  end
  test '#save_mention: 本文に自身のURLを含んだ場合は言及できない' do
    @report1.update(content: "http://localhost:3000/reports/#{@report1.id}")
    assert_not_includes(@report1.mentioning_reports, @report1)
    assert_not_includes(@report1.mentioned_reports, @report1)
  end
end
