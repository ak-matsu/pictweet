require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  before do #beforeの後に共通している部分を前もって定義しておく
    @tweet = FactoryBot.create(:tweet) #createメソッドをつけるとロールバックされ保存された値がすべて消去される。テストのたびにDB保存をさせないため。
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
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
    end
  end
end
