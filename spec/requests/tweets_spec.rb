require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  before do #beforeの後に共通している部分を前もって定義しておく
    @tweet = FactoryBot.create(:tweet) #createメソッドをつけるとロールバックされ保存された値がすべて消去される。テストのたびにDB保存をさせないため。
  end

  #exsampleを整理した処理
  describe "GET #index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
    end
  end
end
