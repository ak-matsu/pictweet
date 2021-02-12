require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      # nicknameが空では登録できないテストコードを記述します。
      user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000')
    end
    it 'emailが空では登録できない' do
      # emailが空では登録できないテストコードを記述します。
    end
  end
end