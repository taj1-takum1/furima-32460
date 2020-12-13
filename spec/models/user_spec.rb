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
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空だと登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailに@が含まれていないと登録できない' do
      @user.email = "aaaaaagmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it '重複するemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'passwordが空だと登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが全角英数字の場合登録できない' do
      @user.password = "１２３ａｂｃ"
      @user.password_confirmation = "１２３ａｂｃ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Input half-width alphanumeric characters.")
    end
    it 'passwordが半角数字のみの場合登録できない' do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Input half-width alphanumeric characters.")
    end
    it 'passwordが半角英字のみの場合登録できない' do
      @user.password = "abcdef"
      @user.password_confirmation = "abcdef"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Input half-width alphanumeric characters.")
    end
    it 'passwordが6文字以上だと登録できる' do
      @user.password = "abc123"
      @user.password_confirmation = "abc123"
      expect(@user).to be_valid
    end
    it 'passwordが5文字以下だと登録できない' do
      @user.password = "abc12"
      @user.password_confirmation = "abc12"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = "abc123"
      @user.password_confirmation = "123abc"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'last_nameが空では登録できない' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank","Last name is invalid. Input full-width characters.")
    end
    it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.last_name = "ｻﾄｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters.")
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank","First name is invalid. Input full-width characters.")
    end
    it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.first_name = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
    end
    it 'last_furiganaが空では登録できない' do
      @user.last_furigana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last furigana can't be blank","Last furigana is invalid. Input full-width characters.")
    end
    it 'last_furiganaが全角カタカナでないと登録できない' do
      @user.last_furigana = "ｻﾄｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last furigana is invalid. Input full-width characters.")
    end
    it 'first_furiganaが空では登録できない' do
      @user.first_furigana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First furigana can't be blank","First furigana is invalid. Input full-width characters.")
    end
    it 'first_furiganaが全角カタカナでないと登録できない' do
      @user.first_furigana = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First furigana is invalid. Input full-width characters.")
    end
    it 'birthdayが空の場合登録できない' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
