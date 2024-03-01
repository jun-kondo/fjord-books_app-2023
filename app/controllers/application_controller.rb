# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    books_url
  end

  def after_sign_out_path_for(_resource)
    # flash[:notice] = t "devise.sessions.signed_out"
    new_user_session_url
  end
end
