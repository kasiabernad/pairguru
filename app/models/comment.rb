class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, presence: true
  validates :movie_id, presence: true

  validates_uniqueness_of :movie_id, scope: :user_id

  def self.for_movie(movie)
    where(movie_id: movie.id)
  end
end
