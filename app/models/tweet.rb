class Tweet < ApplicationRecord
  validates :text, presence: true
  #belongs_toメソッドは1対1の関係
  belongs_to :user #「TweetはUserに属している必要がある」制約が含まれている
  has_many :comments  # commentsテーブルとのアソシエーション
  

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
