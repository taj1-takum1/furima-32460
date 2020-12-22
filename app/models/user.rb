class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  has_many :purchase_records
  has_many :cards, dependent: :destroy

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "が無効です。半角英数字で入力してください。"}

    with_options format: {with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: "が無効です。全角で入力してください。"} do
      validates :last_name
      validates :first_name
    end

    with_options format: {with: /\A[ァ-ヶー－]+\z/, message: "が無効です。全角カナで入力してください。"} do
      validates :last_furigana
      validates :first_furigana
    end
  end
end
