require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '出品済み商品を購入する' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end
    context '出品済み商品が購入できる時' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも購入できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
    context '出品済み商品が購入できない時' do
      it 'postal_codeが空だと購入できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んでいないと購入できないこと' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it 'postal_codeの数字が7つでないと購入できないこと' do
        @order_address.postal_code = '123-456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it 'postal_codeが全角数字だと購入できないこと' do
        @order_address.postal_code = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid')
      end
      it 'prefectureを選択していないと購入できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'cityが空だと購入できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと購入できないこと' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空だと購入できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが全角数字だと購入できないこと' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is not a number')
      end
      it 'phone_numberが12桁以上になると購入できないこと' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number must be less than or equal to 99999999999')
      end
      it 'クレジットカード情報入力に誤りがありtokenが未取得だと購入できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空だと購入できないこと' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと購入できないこと' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
