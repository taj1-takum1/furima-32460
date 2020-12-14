class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :rank_id, :delivery_fee_id, :prefecture_id, :delivery_days_id, :image).merge(user_id: current_user.id)
  end
end
