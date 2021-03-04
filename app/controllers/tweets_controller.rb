class TweetsController < ApplicationController
  # before_action :処理させたいメソッド名 only:オプション[:httpメソッド]
  before_action :set_tweet, only: [:edit, :show]
  # except: 除外する
  before_action :move_to_index,except:[:index, :show, :search]
  
  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
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
    @tweets = Tweet.search(params[:keyword])
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
