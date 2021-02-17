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
      visit user_session_path
      fill_in "Email",with:@user.email
      fill_in "Password",with:@user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')

      # 投稿ページに移動する
      visit new_tweet_path

      # フォームに情報を入力する
      fill_in "Image Url",with:@tweet_image
      fill_in "text",with:@tweet_text

      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Tweet.count}.by(1)

      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq(tweets_path)

      # 「投稿が完了しました」の文字があることを確認する
      expect(page).to have_content('投稿が完了しました')

      # トップページに遷移する
      visit root_path

      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet_image});']"

      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@tweet_text)
    end
  end
  context 'ツイート投稿ができないとき' do
    it 'ログインしてないと新規投稿ページ遷移できない' do
      # トップページに遷移する
      # 新規投稿ページへのリンクがない
    end
  end
end