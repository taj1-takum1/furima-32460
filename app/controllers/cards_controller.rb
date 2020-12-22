class CardsController < ApplicationController
  def new
  end

  def create
    binding.pry
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: 'test',
      card: params[:token]
    )

    card = Card.new(
      card_token: params[:token],
      customer_token: customer.id,
      user_id: current_user.id
    )
    if card.save
      redirect_to root_path
    else
      redirect_to :new
    end
  end
end
