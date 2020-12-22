require 'rails_helper'

RSpec.describe PurchaseRecordBuyerAddress, type: :model do
  describe "商品購入" do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase = FactoryBot.build(:purchase_record_buyer_address, user_id: user.id, item_id: item.id)
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
        expect(@purchase.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'postal_codeが空だと購入できない' do
        @purchase.postal_code = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("郵便番号を入力してください", "郵便番号が無効です。ハイフン(-)を含めてください")
      end
      it 'postal_codeにハイフンが含まれていないと購入できない' do
        @purchase.postal_code = "1234567"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("郵便番号が無効です。ハイフン(-)を含めてください")
      end
      it 'prefectureが空(id=1)だと購入できない' do
        @purchase.prefecture_id = 1
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'cityが空だと購入できない' do
        @purchase.city = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'house_numberが空だと購入できない' do
        @purchase.house_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空だと購入できない' do
        @purchase.phone_number = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberにハイフンが含まれていると購入できない' do
        @purchase.phone_number = "090-5433-4325"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("電話番号が無効です。ハイフン(-)を含めないでください")
      end
      it 'phone_numberが12桁以上では購入できない' do
        @purchase.phone_number = "080123456789"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("電話番号が無効です。ハイフン(-)を含めないでください")
      end
      it 'phone_numberが英数混合では購入できない' do
        @purchase.phone_number = "090abcdefgh"
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("電話番号が無効です。ハイフン(-)を含めないでください")
      end
      it 'user_idがないと購入できない' do
        @purchase.user_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idがないと購入できない' do
        @purchase.item_id = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
