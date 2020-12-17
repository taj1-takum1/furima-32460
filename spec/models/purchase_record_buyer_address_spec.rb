require 'rails_helper'

RSpec.describe PurchaseRecordBuyerAddress, type: :model do
  describe "商品購入" do
    before do
      @purchase = FactoryBot.build(:purchase_record_buyer_address, user_id: 1, item_id: 1)
    end

    context '商品が購入できる場合' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@purchase).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @purchase.building_name = nil
        expect(@purchase).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'tokenが空だと購入できない' do
        @purchase.token = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空だと購入できない' do
        @purchase.postal_code = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeにハイフンが含まれていないと購入できない' do
        @purchase.postal_code = "1234567"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'prefectureが空(id=1)だと購入できない' do
        @purchase.prefecture_id = 1
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと購入できない' do
        @purchase.city = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと購入できない' do
        @purchase.house_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと購入できない' do
        @purchase.phone_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberにハイフンが含まれていると購入できない' do
        @purchase.phone_number = "090-5433-4325"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number is invalid. Don't include hyphen(-)")
      end
      it 'phone_numberが12桁以上では購入できない' do
        @purchase.phone_number = "080123456789"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number is invalid. Don't include hyphen(-)")
      end
      it 'phone_numberが英数混合では購入できない' do
        @purchase.phone_number = "090abcdefgh"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number is invalid. Don't include hyphen(-)")
      end
      it 'user_idがないと購入できない' do
        @purchase.user_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idがないと購入できない' do
        @purchase.item_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
