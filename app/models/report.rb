# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :active_mentions, class_name: 'Mention',
                             foreign_key: 'origin_id',
                             inverse_of: 'origin',
                             dependent: :destroy
  has_many :passive_mentions, class_name: 'Mention',
                              foreign_key: 'destination_id',
                              inverse_of: 'destination',
                              dependent: :destroy
  has_many :mentioning_reports, through: :active_mentions, source: :destination
  has_many :mentioned_reports, through: :passive_mentions, source: :origin

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def save_mentioning_reports
    old_other_reports = mentioning_reports - search_mentioned_reports_from_content
    old_other_reports.each do |old_other_report|
      mentioning_reports.delete(old_other_report)
    end
    new_other_reports = search_mentioned_reports_from_content - mentioning_reports
    new_other_reports.each do |new_other_report|
      mentioning_reports << new_other_report if new_other_report.present? && self != new_other_report
    end
  end

  private

  def search_mentioned_reports_from_content
    permitted_url = %r{http://localhost:3000/reports/\d+}
    other_report_urls = content.scan(permitted_url)
    other_report_urls.map do |other_report_url|
      other_report_id = URI.parse(other_report_url).path.scan(/\d+/)
      Report.find_by(id: other_report_id)
    end
  end
end
