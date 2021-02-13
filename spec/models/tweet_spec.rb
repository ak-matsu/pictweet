require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe 'ツイートの保存' do
    context 'ツイートが投稿できる場合' do
      it '画像とテキストがあれば投稿できる' do
        expect(@tweet).to be_valid
      end
      it 'テキストがあれば投稿できる' do
        @tweet.image = '' #imageを空にした上で、保存されるものであることを確認しています。
        expect(@tweet).to be_valid
      end
    end

    context 'ツイートが投稿できない場合' do
      it 'テキストが空では投稿できない' do
        @tweet.text = ''
        @tweet.valid?
        # binding.pry 「binding.pry」をいれることによってincludeで出力されるメッセージを記述することができる。
        expect(@tweet.errors.full_messages).to include("Text can't be blank")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @tweet.user = nil #生成した@tweetに紐づくユーザーを、nilとして無いものとしている。
        @tweet.valid?
        # binding.pry
        expect(@tweet.errors.full_messages).to include("User must exist")
      end
    end
  end
end
