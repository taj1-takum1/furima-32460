class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  # has_one :purchase_records

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :rank
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_days

  with_options presence: true do
    validates :name
    validates :image
    validates :description
    validates :price, numericality: {only_integer: true, message: "is invalid. Input half-width characters."}
    
    with_options numericality: {other_than: 1, message: "can't be blank"} do
      validates :category_id
      validates :rank_id
      validates :delivery_fee_id
      validates :prefecture_id
      validates :delivery_days_id
    end
  end
    validates :price, numericality: {greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range"}
end
