class Tweet < ApplicationRecord
  validates :text, presence: true
  #belongs_toメソッドは1対1の関係
  belongs_to :user #「TweetはUserに属している必要がある」制約が含まれている
  has_many :comments  # commentsテーブルとのアソシエーション

end
