# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name_or_email' do
    user = create(:user)
    assert_equal user.name_or_email, user.name
    nameless_user = create(:user, name: nil)
    assert_equal nameless_user.name_or_email, nameless_user.email
  end
end
