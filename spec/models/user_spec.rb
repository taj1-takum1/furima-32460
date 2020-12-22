require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '全ての値が正しく入力されていれば保存できる' do
      expect(@user).to be_valid
    end
    it 'nicknameが空だと登録できない' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end
    it 'emailが空だと登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end
    it 'emailに@が含まれていないと登録できない' do
      @user.email = "aaaaaagmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールは不正な値です")
    end
    it '重複するemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
    end
    it 'passwordが空だと登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end
    it 'passwordが全角英数字の場合登録できない' do
      @user.password = "１２３ａｂｃ"
      @user.password_confirmation = "１２３ａｂｃ"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードが無効です。半角英数字で入力してください。")
    end
    it 'passwordが半角数字のみの場合登録できない' do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードが無効です。半角英数字で入力してください。")
    end
    it 'passwordが半角英字のみの場合登録できない' do
      @user.password = "abcdef"
      @user.password_confirmation = "abcdef"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードが無効です。半角英数字で入力してください。")
    end
    it 'passwordが5文字以下だと登録できない' do
      @user.password = "abc12"
      @user.password_confirmation = "abc12"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = "abc123"
      @user.password_confirmation = "123abc"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'last_nameが空では登録できない' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字を入力してください","苗字が無効です。全角で入力してください。")
    end
    it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.last_name = "ｻﾄｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字が無効です。全角で入力してください。")
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください","名前が無効です。全角で入力してください。")
    end
    it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.first_name = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("名前が無効です。全角で入力してください。")
    end
    it 'last_furiganaが空では登録できない' do
      @user.last_furigana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("フリガナ(性)を入力してください","フリガナ(性)が無効です。全角カナで入力してください。")
    end
    it 'last_furiganaが全角カタカナでないと登録できない' do
      @user.last_furigana = "ｻﾄｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("フリガナ(性)が無効です。全角カナで入力してください。")
    end
    it 'first_furiganaが空では登録できない' do
      @user.first_furigana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("フリガナ(名)を入力してください","フリガナ(名)が無効です。全角カナで入力してください。")
    end
    it 'first_furiganaが全角カタカナでないと登録できない' do
      @user.first_furigana = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("フリガナ(名)が無効です。全角カナで入力してください。")
    end
    it 'birthdayが空の場合登録できない' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
  end
end
