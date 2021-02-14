require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザ新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページへ移動する'do
    end
    #トップページに移動する
    visit root_path #visit は root_pathへ遷移することを表す

    #トップページにサインアップページへ遷移するボタンが有る
    expect(page).to have_content('新規登録')
    #page:visitで訪れた先のページの見える部分だけの情報を格納。
    #have_content:vistで訪れたpageの中に「新規登録」という文字列があるか判断するマッチャ。


    #新規登録ページへ移動する
    #ユーザー情報を入力する
    #サインアップボタンを押すとユーザーモデルのカウントが1上がる
    #トップページへ遷移する
    #カーソルを合わせるとログアウトボタンが表示される
    #サインアップボタンへ遷移するボタンや、ログインページへ遷移するボタンが表示されていない
  end

  describe 'ユーザ新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
    end
    #トップページに移動する
    #トップページにサインアップページへ遷移するボタンがある
    #新規登録ページへ移動する
    #ユーザー情報を入力する
    #サインアップボタンを押してもユーザーモデルのカウントは上がらない
    #新規登録ページへ戻される
  end


end
