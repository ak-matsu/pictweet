module TweetsHelper
  # tweet_listsメソッドにtweetsという引数をもたせている
  def tweet_lists(tweets)
    # 空の箱としてhtmlを生成
    html  = ''
    tweets.each do |tweet|
      # renderメソッドは部分テンプレートを呼び出す。
      # partial:オプションで該当する部分テンプレートを表示。
      # locals:オプションで部分テンプレートの変数を使える。
      # tweetの部分テンプレートを呼び出し、表示、tweetという変数を使う
      html +=  render(partial: "tweet", locals: { tweet: tweet })
    end
    return raw(html)
  end
end