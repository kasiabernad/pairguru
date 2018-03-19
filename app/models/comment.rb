class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true, touch: true
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, presence: true

  validates_uniqueness_of :movie_id, scope: :user_id

  def self.recent
    where('created_at >= ?', 7.days.ago.utc.beginning_of_day)
  end
end
