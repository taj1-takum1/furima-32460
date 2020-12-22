class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :purchase_record

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
    validates :price, numericality: {only_integer: true, message: "が無効です。半角数字で入力してください"}
    
    with_options numericality: {other_than: 1, message: "を入力してください"} do
      validates :category_id
      validates :rank_id
      validates :delivery_fee_id
      validates :prefecture_id
      validates :delivery_days_id
    end
  end
    validates :price, numericality: {greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "が設定範囲外です"}
end
