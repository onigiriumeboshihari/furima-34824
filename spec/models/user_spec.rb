require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録できるとき' do
      it 'ニックネームとメールアドレス、パスワードを確認用含めて2回入力すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上であれば登録できる' do
        @user.password = '00hoge'
        @user.password_confirmation = '00hoge'
        expect(@user).to be_valid
      end
      it 'パスワードが半角英数字混合であれば登録できる' do
        @user.password = '00hoge'
        @user.password_confirmation = '00hoge'
        expect(@user).to be_valid
      end
      it 'パスワードとパスワード確認が一致していれば登録できる' do
        @user.password = '00hoge'
        @user.password_confirmation = '00hoge'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'パスワードを入力してもパスワード確認が空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'パスワードとパスワード確認が一致しないと登録できない' do
        @user.password = '2222hoge'
        @user.password_confirmation = '3333hoge'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '重複したメールアドレスが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'パスワードが5文字以下では登録できない' do
        @user.password = 'hoge2'
        @user.password_confirmation = 'hoge2'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'パスワードが半角英字のみでは登録できない' do
        @user.password = 'hogehoge'
        @user.password_confirmation = 'hogehoge'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて半角で設定してください")
      end
      it 'パスワードが半角数字のみでは登録できない' do
        @user.password = '222222'
        @user.password_confirmation = '222222'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて半角で設定してください")
      end
      it 'パスワードが全角では登録できない' do
        @user.password = 'ホゲホゲホゲ'
        @user.password_confirmation = 'ホゲホゲホゲ'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて半角で設定してください")
      end
      it 'メールアドレスが@なしでは登録できない' do
        @user.email = 'testpass'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
    end
  end
  describe '新規登録/本人情報確認' do
    context '新規登録できるとき' do
      it 'ユーザー本名は、名字と名前をそれぞれ入力すると登録できる' do
        @user.last_name = '名字'
        @user.first_name = '名前'
        expect(@user).to be_valid
      end
      it 'ユーザー本名は、全角で入力すると登録できる' do
        @user.last_name = '名字'
        @user.first_name = '名前'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは、名字と名前をそれぞれ入力すると登録できる' do
        @user.last_name = 'ミョウジ'
        @user.first_name = 'ナマエ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは、全角のカタカナで入力すると登録できる' do
        @user.last_name = 'ミョウジ'
        @user.first_name = 'ナマエ'
        expect(@user).to be_valid
      end
      it '生年月日を入力すると登録できる' do
        @user.birthday = '1930-01-01'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ユーザー本名の名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を入力してください", "姓は全角文字を使用してください")
      end
      it 'ユーザー本名の名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前は全角文字を使用してください")
      end
      it 'ユーザー本名の名字のフリガナが空では登録できない' do
        @user.last_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓のフリガナを入力してください", "姓のフリガナは全角カナを使用してください")
      end
      it 'ユーザー本名の名前のフリガナが空では登録できない' do
        @user.first_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前のフリガナを入力してください", "名前のフリガナは全角カナを使用してください")
      end
      it 'ユーザー本名の名字が半角では登録できない' do
        @user.last_name = 'lastname'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓は全角文字を使用してください")
      end
      it 'ユーザー本名の名前が半角では登録できない' do
        @user.first_name = 'firstname'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角文字を使用してください")
      end
      it 'ユーザー本名の名字のフリガナがカタカナ以外では登録できない' do
        @user.last_kana = '名字'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓のフリガナは全角カナを使用してください")
      end
      it 'ユーザー本名の名前のフリガナがカタカナ以外では登録できない' do
        @user.first_kana = '名前'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前のフリガナは全角カナを使用してください")
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
