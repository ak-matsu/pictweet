require 'rails_helper'

RSpec.describe "ツイート投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet_text = Faker::Lorem.sentence
    @tweet_image = Faker::Lorem.sentence
  end
  context 'ツイート投稿ができるとき' do
    it 'ログインしたユーザーは新規登録ができる' do
      # ログインする
      binding.pry
      # 新規投稿ページへのリンクがあることを確認する
      # 投稿ページに移動する
      # フォームに情報を入力する
      # 送信するとTweetモデルのカウントが1上がることを確認する
      # 投稿完了ページに遷移することを確認する
      # 「投稿が完了しました」の文字があることを確認する
      # トップページに遷移する
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
    end
  end
  context 'ツイート投稿ができないとき' do
    it 'ログインしてないと新規投稿ページ遷移できない' do
      # トップページに遷移する
      # 新規投稿ページへのリンクがない
    end
  end
end