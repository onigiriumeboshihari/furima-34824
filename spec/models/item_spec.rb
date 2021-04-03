require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できるとき' do
      it '商品画像、商品名、商品の説明、カテゴリー、商品の状態、配送料の負担、発送元の地域、発送までの日数、販売価格が入力されると出品できる' do
        expect(@item).to be_valid
      end
      it '販売価格が半角数字で入力されると出品できる' do
        expect(@item).to be_valid
      end
      it '販売価格が¥300~¥9,999,999の間で入力されると出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できないとき' do
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("名前を入力してください")
      end
      it '商品の説明が空では登録できない' do
        @item.introduction = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("説明を入力してください")
      end
      it 'カテゴリーが---では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは1以外の値にしてください")
      end
      it '商品の状態が---では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("状態は1以外の値にしてください")
      end
      it '配送料の負担が---では登録できない' do
        @item.shipping_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は1以外の値にしてください")
      end
      it '発送元の地域が---では登録できない' do
        @item.shipped_from_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は1以外の値にしてください")
      end
      it '発送までの日数が---では登録できない' do
        @item.arrive_in_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は1以外の値にしてください")
      end
      it '販売価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", "価格は数値で入力してください", "価格は一覧にありません")
      end
      it '販売価格が全角表記では登録できない' do
        @item.price = '300円'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it '販売価格が半角英字表記では登録できない' do
        @item.price = '300en'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it '販売価格が半角記号表記では登録できない' do
        @item.price = '¥9,999,999'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it '販売価格が¥300未満では登録できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は一覧にありません")
      end
      it '販売価格が¥10,000,000以上では登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は一覧にありません")
      end
      it 'userが紐づいていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
