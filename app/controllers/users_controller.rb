class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def show
    @user = User.find(params[:id])
  end
  private
  def move_to_index
    unless user_signed_in? && current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end
end
