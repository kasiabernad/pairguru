require "rails_helper"

describe Comment do
  it{ should belong_to :user }
  it{ should belong_to :movie }

  it{ should validates_uniqueness_of(:movie_id).scoped_to(:user_id) }
  it{ should validates_presence_of(:movie_id) }
  it{ should validates_presence_of(:user_id) }
end
