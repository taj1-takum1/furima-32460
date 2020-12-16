class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_index, only: :index

  def index
    @purchase_record_buyer_address = PurchaseRecordBuyerAddress.new
  end

  def create
    @purchase_record_buyer_address = PurchaseRecordBuyerAddress.new(purchase_record_params)
    if @purchase_record_buyer_address.valid?
      pay_item
      @purchase_record_buyer_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end

  private
  def purchase_record_params
    params.require(:purchase_record_buyer_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_number, :phone_number).merge(token: params[:token], item_id: params[:item_id], user_id: current_user.id)
  end

  def move_to_index
    if current_user.id == @item.user.id || @item.purchase_record.present?
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_record_params[:token],
      currency: 'jpy'
    )
  end
end
