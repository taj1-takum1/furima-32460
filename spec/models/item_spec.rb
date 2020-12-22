require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "商品出品" do
    before do
      @item = FactoryBot.build(:item)
    end
    
    context '商品が出品できる場合' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
      end
    end
    context '商品が出品できない場合' do
      it 'nameが空だと出品できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'descriptionが空だと出品できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'priceが空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it 'priceが半角数字でないと出品できない' do
        @item.price = "１０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格が無効です。半角数字で入力してください")
      end
      it 'priceの範囲が299以下の場合出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格が設定範囲外です")
      end
      it 'priceの範囲が10000000以上の場合出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格が設定範囲外です")
      end
      it 'categoryが空(id=1)だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it 'rankが空(id=1)だと出品できない' do
        @item.rank_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it 'delivery_feeが空(id=1)だと出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it 'prefectureが空(id=1)だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it 'delivery_daysが空(id=1)だと出品できない' do
        @item.delivery_days_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end
      it 'imageが空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end
      it 'userが紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
