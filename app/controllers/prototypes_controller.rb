class PrototypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prototype, only: [:edit, :show, :delete]
  before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def show
    @prototype = Prototype.find(params[:prototype_id] || params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else 
      render :edit  #renderが来たらedit(今回の場合)にインスタンス変数を使用して値を渡さなくてはいけない。
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private
  def move_to_index
    unless user_signed_in? && current_user.id =! @prototype.user.id
      redirect_to action: :index
    end
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end