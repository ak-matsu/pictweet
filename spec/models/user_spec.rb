require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    # .buildは一時的にデータを書き込む。
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        # be_validはvalid?メソッドの返り値が、trueであること正常系のテストを行うマッチャ
        expect(@user).to be_valid
      end
      it 'nicknameが6文字以下であれば登録できる' do
        @user.nickname = 'aaaaaa'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        expect(@user).to be_valid
      end
    end
    
    context '新規登録でないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        #@user.errors
        #@user.errors.full_messages
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'nicknameが7文字以上では登録できない' do
        @user.nickname = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname is too long (maximum is 6 characters)')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save #@userをテーブルに保存したあと
        another_user = FactoryBot.build(:user) #再度別のユーザーanother_userを生成
        another_user.email = @user.email #ここでanother_userのemailにすでに保存済みの@userのemailを上書き
        another_user.valid? #valid?でanother_userが保存されるか判別。
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)') 
      end
    end
  end
end