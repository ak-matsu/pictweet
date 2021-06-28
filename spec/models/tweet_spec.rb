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
    end

    context 'ツイートが投稿できない場合' do
      it 'テキストが空では投稿できない' do
        @tweet.text = ''
        @tweet.valid?
        # binding.pry 「binding.pry」をいれることによってincludeで出力されるメッセージを記述することができる。
        expect(@tweet.errors.full_messages).to include('テキストを入力してください')
      end

      it '画像がないとツイートは保存できない' do
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('画像を入力してください')
      end

      it 'ユーザーが紐付いていなければ投稿できない' do
        @tweet.user = nil #生成した@tweetに紐づくユーザーを、nilとして無いものとしている。
        @tweet.valid?
        # binding.pry
        expect(@tweet.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
