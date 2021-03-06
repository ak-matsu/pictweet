require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  before do #beforeの後に共通している部分を前もって定義しておく
    #.createメソッドはテスト用DBが保存される。
    @tweet = FactoryBot.create(:tweet) 
  end

  #exsampleを整理した処理
  describe "GET #index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path #indexアクションにリクエストを送るため、get root_pathを使用。
      expect(response.status).to eq(200) 
      #expectによりカッコ内が想定通りか確認する。response.statusと実行すると返ってくる値が200であればよい
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do
      get root_path
      expect(response.body).to include(@tweet.text)
      #expectによりresponse.bodyを実行、返ってきた値は文字列のためincludeとなる。
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do
      get root_path
      expect(response.body).to include(@tweet.image)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get root_path
      expect(response.body).to include('投稿を検索する')
    end
  end

  describe 'GET #show'do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる'do
      get tweet_path(@tweet)
      expect(response.status).to eq(200)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する'do
      get tweet_path(@tweet)
      expect(response.body).to include(@tweet.text)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する'do
      get tweet_path(@tweet)
      expect(response.body).to include(@tweet.image)
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する'do
      get tweet_path(@tweet)
      expect(response.body).to include('＜コメント一覧＞')
    end
  end
end
