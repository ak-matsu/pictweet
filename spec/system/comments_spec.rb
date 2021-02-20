require 'rails_helper'

RSpec.describe "コメント投稿", type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in "Email",with:@tweet.user.email
    fill_in "Password",with:@tweet.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # ツイート詳細ページに遷移する
    visit tweet_path(@tweet)

    # フォームに情報を入力する
    fill_in 'コメントする',with:@comment

    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change {Comment.count}.by(1)


    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq tweet_path(@tweet)

    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment

  end

end
