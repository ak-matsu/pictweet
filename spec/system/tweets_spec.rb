require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet_text = Faker::Lorem.sentence
    @tweet_image = Faker::Lorem.sentence
  end
  context 'ツイート投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)

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
      }.to change { Tweet.count }.by(1)

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
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path

      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')

    end
  end
end

RSpec.describe 'ツイート編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート編集できるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do      
      # ツイート1を投稿したユーザーでログインする
      sign_in(@user)

      #クリックされログイン後の画面は、
      #root_pathに戻ってくることを確認する処理。

      # ツイート1に「編集」ボタンがあることを確認する
      expect(
        all('.more')[1].hover
      ).to have_link '編集', href: edit_tweet_path(@tweet1)

      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)

      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#tweet_image').value #tweet_imageというid名が付与された要素の値を取得
      ).to eq(@tweet1.image)

      expect(
        find('#tweet_text').value #tweet_textというid名が付与された要素の値を取得
      ).to eq(@tweet1.text)
      
      # 投稿内容を編集する
      fill_in 'tweet_image', with: "#{@tweet1.image}+編集した画像URL"
      fill_in 'tweet_text',with: "#{@tweet1.text}+編集したテキスト"

      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Tweet.count}.by(0)

      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(tweet_path(@tweet1))

      # 「更新が完了しました」の文字があることを確認する
      expect(page).to have_content('更新が完了しました')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet1.image}+編集した画像URL);']"

      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）    
      expect(page).to have_content("#{@tweet1.text}+編集したテキスト")
    end
  end

  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@user)

      # ツイート2に「編集」ボタンがないことを確認する
      expect(
        all('.more')[0].hover
      ).to have_no_link '編集',href: edit_tweet_path(@tweet2)

    end
    it 'ログインしていないとツイートの編集画面には画面遷移できない' do
      # トップページにいる
      visit root_path

      # ツイート1に「編集」ボタンがないことを確認する
      expect(
        all('.more')[1].hover
      ).to have_no_link '編集',href: edit_tweet_path(@tweet1)

      # ツイート2に「編集」ボタンがないことを確認する
      expect(
        all('.more')[0].hover
      ).to have_no_link '編集',href: edit_tweet_path(@tweet2)
    end
  end
end

RSpec.describe 'ツイート削除', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@user)
      

      # ツイート1に「削除」ボタンがあることを確認する
      expect(
        all('.more')[1].hover
      ).to have_link '削除', href: tweet_path(@tweet1)

      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        all('.more')[1].hover.find_link('削除',href: tweet_path(@tweet1)).click
      }.to change {Tweet.count }.by(-1)

      # 削除完了画面に遷移したことを確認する
      expect(current_path).to eq(tweet_path@tweet1)

      # 「削除が完了しました」の文字があることを確認する
      expect(page).to have_content('削除が完了しました')

      # トップページに遷移する
      visit root_path
      # トップページにはツイート1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector ".content_post[style='background-image: url(#{@tweet1.image});']"

      # トップページにはツイート1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content("#{@tweet1.text}")

    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@user)
      
      # ツイート2に「削除」ボタンが無いことを確認する
      expect(
        all('.more')[0].hover
      ).to have_no_link '削除', href: tweet_path(@tweet2)

    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit root_path

      # ツイート1に「削除」ボタンが無いことを確認する
      expect(
        all('.more')[1].hover
      ).to have_no_link '削除', href: tweet_path(@tweet1)

      # ツイート2に「削除」ボタンが無いことを確認する
      expect(
        all('.more')[0].hover
      ).to have_no_link '削除', href: tweet_path(@tweet2)
    end
  end
end

RSpec.describe 'ツイート詳細', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
  end
  it 'ログインしたユーザーはツイート詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    sign_in(@user)

    # ツイートに「詳細」ボタンがあることを確認する
    expect(
      all('.more')[0].hover
    ).to have_link '詳細', href: tweet_path(@tweet)

    # 詳細ページに遷移する
    visit tweet_path(@tweet)

    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet.image});']"
    expect(page).to have_content("#{@tweet.text}")

    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'

  end
  it 'ログインしていない状態でツイート詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path

    # ツイートに「詳細」ボタンがあることを確認する
    expect(
      all('.more')[0].hover
    ).to have_link '詳細', href: tweet_path(@tweet)

    # 詳細ページに遷移する
    visit tweet_path(@tweet)

    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet.image});']"

    # フォームが存在しないことを確認する
    expect(page).to have_no_selector'form'

    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content("コメントの投稿には新規登録/ログインが必要です")
  end
end