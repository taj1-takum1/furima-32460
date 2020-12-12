class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  has_many :purchase_records
  with_options presence: true do
    validates :nickname
    validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "is invalid. Input half-width alphanumeric characters."}
    validates :last_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: "is invalid. Input full-width characters."}
    validates :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: "is invalid. Input full-width characters."}
    validates :last_furigana, format: {with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width characters."}
    validates :first_furigana, format: {with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width characters."}
    validates :birthday
  end
end
