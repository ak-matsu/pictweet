require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザ新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページへ移動する'do
    
    #トップページに移動する
    visit root_path #visit は root_pathへ遷移することを表す

    #トップページにサインアップページへ遷移するボタンが有る
    expect(page).to have_content('新規登録')
    #page:visitで訪れた先のページの見える部分だけの情報を格納。
    #have_content:visitで訪れたpageの中に「新規登録」という文字列があるか判断するマッチャ。


    #新規登録ページへ移動する
    visit new_user_registration_path #ユーザー情報を登録するため

    #ユーザー情報を入力する
    fill_in 'Nickname',with: @user.nickname
    fill_in 'Email',with: @user.email
    fill_in 'Password',with:@user.password
    fill_in 'Password confirmation',with:@user.password_confirmation
    #fill_in 'フォームの名前', with: '入力する文字列'のように記述することで、フォームへの入力を行うことができる。

    #サインアップボタンを押すとユーザーモデルのカウントが1上がる
    expect{
      find('input[name="commit"]').click #find('クリックしたい要素').clickと記述することで、実際にクリックができる
    }.to change {User.count}.by(1)

    #トップページへ遷移する
    expect(current_path).to eq(root_path)

    #カーソルを合わせるとログアウトボタンが表示される
    #サインアップボタンへ遷移するボタンや、ログインページへ遷移するボタンが表示されていない
    end
  end

  context 'ユーザ新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
    
    #トップページに移動する
    #トップページにサインアップページへ遷移するボタンがある
    #新規登録ページへ移動する
    #ユーザー情報を入力する
    #サインアップボタンを押してもユーザーモデルのカウントは上がらない
    #新規登録ページへ戻される
    end
  end


end
