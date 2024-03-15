# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'pngファイルを1件添付できる' do
    user = create(:user, :attached_png)
    expect(user.image).to be_attached
  end

  it 'jpgファイルを1件添付できる' do
    user = create(:user, :attached_jpg)
    expect(user.image).to be_attached
  end

  it 'gifファイルを1件添付できる' do
    user = create(:user, :attached_gif)
    expect(user.image).to be_attached
  end
end
