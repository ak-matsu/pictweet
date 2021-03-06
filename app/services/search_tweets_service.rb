class SearchTweetsService
  def self.search(search)
  # もし検索フォームに何も入力せず検索ボタンを押すと、引数は空になり、elseが処理される
  # この場合、Tweet.allで全てのTweetを取得、表示させる。
    if search != ""
    # whereで条件をつけてLIKEであいまい検索
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end