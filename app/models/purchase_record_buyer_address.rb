class PurchaseRecordBuyerAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :token, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :house_number
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "is invalid. Don't include hyphen(-)"}
    validates :token
    validates :user_id
    validates :item_id
  end
  
  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    BuyerAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_record_id: purchase_record.id)
  end
end