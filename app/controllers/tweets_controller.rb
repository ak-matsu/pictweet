class TweetsController < ApplicationController
  # before_action :処理させたいメソッド名 only:オプション[:httpメソッド]
  before_action :set_tweet, only: [:edit, :show]
  # except: 除外する
  before_action :move_to_index,except:[:index, :show, :search]
  
  def index
    #orderメソッド並び替え 降順
    # @tweets = Tweet.includes(:user).order("created_at DESC")
    query = "SELECT * FROM tweets"
    @tweets = Tweet.find_by_sql(query)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    #バリデーションで問題があれば、保存はされず「投稿画面」に戻る
    if @tweet.valid?
      @tweet.save
      redirect_to root_path
    else
      #保存されなければ、newに戻る
      render 'new'
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
    
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = SearchTweetsService.search(params[:keyword])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # indexページへリダイレクト
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
