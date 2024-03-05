class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params)
  end

  def show
  end
end
