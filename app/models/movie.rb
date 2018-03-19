# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre
  has_many :comments
<<<<<<< HEAD
  validates_with TitleBracketsValidator

  def additional_info
    response = Typhoeus.get(escape_uri)

    response.success? ? JSON.parse(response.body) : nil
  end

  def escape_uri
    URI.escape("https://pairguru-api.herokuapp.com/api/v1/movies/#{title}")
  end
=======
>>>>>>> feature: add comments to movies, validate uniqueness
end
