class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #has_manyメソッド :モデル 1対多の繋がりを表すメソッド
  has_many :tweets  #userが1に対して複数のtweetsテーブルとのアソシエーション
  has_many :comments #commentsテーブルとのアソシエーション

  # nicknameとして保存できる値は最大6文字まで
  validates :nickname, presence: true, length: { maximum: 6}
end
