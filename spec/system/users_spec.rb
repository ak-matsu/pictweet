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
    expect(
      find('.user_nav').find('span').hover
    ).to have_content('ログアウト')
    #have:find('ブラウザ上の要素').hoverとすることで、特定の要素にカーソルをあわせたときの動作を再現できる。
    #ログアウトボタンはヘッダーの中のspan要素をhoverすることで現れる。しかし、span要素は他でも使われているため、その親要素のuser_navクラスもあわせて指定させている。
    

    #サインアップボタンへ遷移するボタンや、ログインページへ遷移するボタンが表示されていない
    expect(page).to have_no_content('新規登録')
    expect(page).to have_no_content('ログイン')
    #ログインに成功しているから、「新規登録」、「ログイン」が表示されてない。
    end
  end

  context 'ユーザ新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      
      #トップページに移動する
      visit root_path

      #トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
    
      #新規登録ページへ移動する
      visit new_user_registration_path

      #ユーザー情報を入力する
      fill_in 'Nickname', with: ''
      fill_in 'Email',with: ''
      fill_in 'Password',with: ''
      fill_in 'Password confirmation',with:''

      #サインアップボタンを押してもユーザーモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)

      #新規登録ページへ戻される
      expect(current_path).to eq('/users')
    end
  end
end

#ユーザーログインの結合テストコード
RSpec.describe 'ログイン', type: :system do
  #すでに登録されているユーザーに対しての挙動確認はFactoryBot.create(:user)としています。
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      #トップページに移動できる
      visit root_path

      #トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')

      #ログインページへ遷移する
      visit new_user_session_path

      #正しいユーザー情報を入力する
      fill_in 'Email', with: @user.email
      fill_in 'Password',with: @user.password

      #ログインボタンを押す
      find('input[name="commit"]').click

      #トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)

      #カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.user_nav').find('span').hover
      ).to have_content('ログアウト')

      #サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      #トップページに移動する
      #トップページにログインページへ遷移するボタンが有ることを確認する
      #ログインページへ遷移する
      #ユーザー情報を入力する
      #ログインページへ戻されることを確認する
    end
  end
end