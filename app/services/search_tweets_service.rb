class SearchTweetsService
  def self.search(search)
  # もし検索フォームに何も入力せず検索ボタンを押すと、引数は空になり、elseが処理される
  # この場合、Tweet.allで全てのTweetを取得、表示させる。
    if search != ""
      # SQLインジェクションの対策
      search = "%#{search}%"
      Tweet.find_by_sql(["select * from tweets where text like ? ", search])
    else
      Tweet.all
    end
  end
end