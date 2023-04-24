class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(search,word)
    if search == 'perfect'
      Book.where(title: word)
    elsif search == 'forward'
      Book.where('name LIkE ?', word + '%')
    elsif search == 'backward'
      Book.where('name LIkE ?', '%' + word)
    else
      Book.where('name LIKE ?', '%' + word + '%')
    end
  end

end
