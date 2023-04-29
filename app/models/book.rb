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

 scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
 scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
 scope :created_days_2ago, -> { where(created_at: 2.day.ago.all_day) }
 scope :created_days_3ago, -> { where(created_at: 3.day.ago.all_day) }
 scope :created_days_4ago, -> { where(created_at: 4.day.ago.all_day) }
 scope :created_days_5ago, -> { where(created_at: 5.day.ago.all_day) }
 scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
 scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
end