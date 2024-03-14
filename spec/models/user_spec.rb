# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'pngファイルを1件添付できる' do
    user = create(:user, :attached_png)
    expect(user.image).to be_attached
  end

  it 'jpegファイルを1件添付できる' do
    user = create(:user, :attached_jpeg)
    expect(user.image).to be_attached
  end

  it 'gifファイルを1件添付できる' do
    user = create(:user, :attached_gif)
    expect(user.image).to be_attached
  end
end
